class BookFacade
  def get_books(location, quantity)
    json = BookService.search_books(location, quantity) # hitting methods in service
    Books.new(json)
  end
end