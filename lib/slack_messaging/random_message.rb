module SlackMessaging
  class RandomMessage
    def self.acquire_random_quote
      random_quote = HTTParty.get('http://api.quotable.io/random', headers: { 'Content-Type': 'application/json' }).body
      quote_content = JSON.parse(random_quote)['content']
      quote_author = JSON.parse(random_quote)['author']
      return "\"#{quote_content}\"" + "\n" + "—#{quote_author}"
    end
  end
end
