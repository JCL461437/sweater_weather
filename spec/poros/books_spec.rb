require 'rails_helper'

RSpec.describe Books do
  it 'instantiates a Books object with the correct attributes from the JSON response' do
    json_data = File.read('spec/fixtures/book_for_city.json')
    parsed_data = JSON.parse(json_data)

    books = Books.new(parsed_data)

    expect(books).to be_a(Books)
    expect(books.total_books_found).to eq(parsed_data['numFound'])
    
    expect(books.books.size).to eq(parsed_data['docs'].size) #makes sure same number of books are in the poros as the docs array from json

    parsed_data['docs'].each_with_index do |book, books_index|
      expect(books.title(books_index)).to eq(book['title'])
      expect(books.isbn(books_index)).to eq(book['isbn'] || ["ISBN value not available"])
      expect(books.publisher(books_index)).to eq(book['publisher'] || ["Publisher not available"])
    end
  end
end