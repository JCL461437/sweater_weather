class Api::V1::BookController < ApplicationController
  def book-search
    location = params[:location]
    quantity = params[:quantity]

    books = BookFacade.new.get_books(location, quantity)
    
    render json: BookSerializer.the_books(books)
  end
end