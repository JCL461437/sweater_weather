class BookService

  BASE_URL = "https://openlibrary.org"

  def self.connection 
    Faraday.new(url: BASE_URL) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def self.search_books(location, quantity)
    response = connection.get("/search.json?q=#{location}&place:#{location}&limit=#{quantity}")
    JSON.parse(response.body, symbolize_names: true)
  end
end