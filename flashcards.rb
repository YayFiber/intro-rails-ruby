# card1 = "cat|neko" #Will have a front and back
# card2 = "dog|inu"

# -------
# lets not split strings, hashes! like JS objects at first glance
# hash keys can be any data type, including arrays, hashs, etc
#symbols are the quickets way to access hash data, looks like: :symbol
#accessing symbols is simiar: obj[:symbol]



# ====================================
# Symbols can be typed like this example below 

# card1 = {
#   :front => "cat",
#   :back => "neko"
# }
# card2 = {
#   :front => "dog",
#   :back => "inu"
# }

# However, the shorthand version is exactly like Javascript objects:

# card1 = {
#   front: "Cat",
#   back: "neko"
# }
# card2 = {
#   front: "dog",
#   back: "inu"
# }

# ============================

#classes are capitalized first letters
#to make an instance with a class use Card.new
# card = Card.new
# new allocates an instance, and calls an initialize method, which you can customize with args

#There are scope variables, which are like they sound, only accessible within the scope in which they were defined. But there are instance variables to help solve this, syntax with @.

# You can access instance variables with something like: card.instance_variable_get("@front")
# but I have a feeling that something far less tedious will soon reveal itself to me
#aha, I defined a front method that returns front, no return because Ruby returns last valle that was determined
module Flashcards # wrapping all of this in a module helps reduce name collision.

  class Application
    def initialize
      @decks = []
    end

    def << deck
      @decks << deck
    end

    def play
      display_decks
      puts "Pick a deck: "
      deck = get_deck
      deck.play
    end

    def display_decks 
      # @decks.each do |deck| ---- theres a cleaner way to do simple do-ends
      #   puts deck.name
      # end

      @decks.each { |deck| puts deck.name } # This is the same as the aboce
    end

    def get_deck
      name = gets.chomp
      @decks.detect do |deck| ## detect == .find
        deck.name == name
      end
    end
  end

  class Card 
    # attr_reader :front, :back
    # attr_writer :front, :back
    #ohohoho you thought you weredone shortening things?! never. enter attr_accessor which combines those two tedious lines into one. BEHOLD:
    attr_accessor :front, :back
    # you must use symbols for attr_accessor, not @ signs.
    def initialize(front, back)
      @front = front
      @back = back
    end

    def correct? guess #question mark not important to ruby, but expresses intent of developer to return true or false. in JS, we'd right is_correct. 
      guess == @back
    end

    def play
      puts "#{front} > "
      guess = gets.chomp
      if correct? guess
        puts "Correct"
      else 
        puts "Incorrect. The answer was #{back}."
      end
    end

    #getter method

    # def front
    #   @front
    # end

    # the getter method above and attr_reader below are the same, as writing these out would give us huge classes eventually. Using attr_reader is much simpler. same for attr_writer below
    # You can also add more than one reader, writer per line. I am going to move these attr_readers and writers to the top
    # attr_reader :front

    #setter method

    # def front= front
    #   @front = front
    # end

    # attr_writer :front
  end

  class MultipleAnswerCard < Card #INHERITANCE
    def correct? guess
      answers = back.split(",")
      answers.any? { |answer| answer == guess } #any returns true of false if anything meets the statement
    end
  end

  class Deck
    attr_accessor :name
    attr_reader :cards, :name
    def initialize name
      @name = name
      @cards = []
    end

    def << card
      @cards << card ## << is the push operator. 
    end

    def play
      puts "Playing the #{name} deck."
      shuffle
      @cards.each(&:play) #the ampersand calls the following symbol on the object passed to it.
    end

    def shuffle
      # @cards = @cards.shuffle -- this would work, but there is an easier way
      @cards.shuffle! #shuffle with an exclamation lets you manipulate original instance, where the previous line is us making a copy, shuffling it, and assigning it to the original value. Wasting memory?
    end
  end
end

card1 = Flashcards::Card.new("cat", "neko")
card2 = Flashcards::Card.new("dog", "inu")
card3 = Flashcards::Card.new('snake', 'hebi')
card4 = Flashcards::MultipleAnswerCard.new("Violin", "baiorin,viiorin")

deck = Flashcards::Deck.new('Japanese') #arrays! Ruby arrays, like JS, can have multiple data types 
deck << card1
deck << card2
deck << card3
deck << card4

deck2 = Flashcards::Deck.new("Russian")

app = Flashcards::Application.new
app << deck
app << deck2
app.play

# deck.cards.each do |card| #array.forEach(card =>)
#   # card_parts = card.split("|") #returns array, like JS
#   # front = card_parts[0]
#   # back = card_parts[1]

#   front = card.front
#   back = card.back

#   print "#{front} >"
#   guess = gets.chomp #Chomp removes the inclusion of new line at end of a string.
  
#   if card.correct?(guess)
#     puts "Correct"
#   else
#     puts "Incorrect, the answer was #{back}"
#   end
# end