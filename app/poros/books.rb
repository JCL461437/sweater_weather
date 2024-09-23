class Books
  attr_reader :total_books_found, :books, 
              :isbn, :title, :publisher

  def initialize(data)
    # Ensure data is a hash and not an array or other type
    data = data.is_a?(Hash) ? data : {}

    @total_books_found = 
    @books = 
    @isbn = 
    @title = 
    @publisher = 
  end
end