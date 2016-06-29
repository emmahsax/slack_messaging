module SlackMessaging
  class RandomMessage
    attr_accessor :text

    MESSAGE_ARRAY = [
        "A true friend is someone who thinks that you are a good egg even though he knows that you are slightly cracked.\n--Bernard Meltzer",
        "If you can't make it good, at least make it look good.\n--Bill Gates",
        "I'm convinced of this: Good done anywhere is good done everywhere.\n--Maya Angelou",
        "The real trouble with reality is that there's no background music.\n--Anonymous",
        "Whatever you are, be a good one.\n--Abraham Lincoln",
        "Good, better, best. Never let it rest. 'Til your good is better and your better is best.\n--St. Jerome",
        "Despite everything, I believe that people are really good at heart.\n--Anne Frank",
        "Life is 10% what happens to you and 90% how you react to it.\n--Charles R. Swindoll",
        "The way to get started is to quit talking and begin doing.\n--Walt Disney",
        "A creative man is motivated by the desire to achieve, not by the desire to beat others.\n--Ayn Rand",
        "Problems are not stop signs, they are guidelines.\n--Robert H. Schuller",
        "Correction does much, but encouragement does more.\n--Johann Wolfgang von Goethe",
        "Positive anything is better than negative nothing.\n--Elbert Hubbard",
        "To succeed, you need to find something to hold on to, something to motivate you, something to inspire you.\n--Joyce Meyer",
        "If you're not making mistakes, then you're not doing anything. I'm positive that a doer makes mistakes.\n--John Wooden",
        "The best way to deal with other people is to just let them be other people.\n--Anonymous",
        "Talk to yourself like you would to someone you love.\n--Brenee Brown",
      ]

    def initialize
      self.text = MESSAGE_ARRAY[rand(MESSAGE_ARRAY.length)]
    end

    def get_text
      return self.text
    end
  end
end
