class Books
  attr_reader :total_books_found, :books

  def initialize(data)
    data = data.is_a?(Hash) ? data : {}
    
    @total_books_found = data['numFound']
    @books = data['docs'].map do |book|
      {
        isbn: book['isbn'] || ["ISBN value not available"],
        title: book['title'] || "Title not available",
        publisher: book['publisher'] || ["Publisher not available"]
      }
    end
  end

  # allows us to call books attributes as if they were instance variables
  def isbn(index)
    @books[index][:isbn]
  end

  def title(index)
    @books[index][:title]
  end

  def publisher(index)
    @books[index][:publisher]
  end
end
