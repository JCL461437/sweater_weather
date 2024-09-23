require 'rails_helper'

RSpec.describe BookService do
  it 'can #search_books' do
    location = "salt lake city"
    quantity = 3

    json_response = File.read('spec/fixtures/book_for_city.json') # REMEBER: quantity and limit of three 
    stub_request(:get, "/search.json?q=#{location}&place:#{location}&limit=#{quantity}").to_return(status: 200, body: json_response)
    book_response = JSON.parse(json_response, symbolize_names: true)

    expect(book_response).to be_a Hash

    expect(book_response).to have_key(:numFound)
    expect(book_response[:numFound]).to eq(1999)

    expect(book_response).to have_key(:q)
    expect(book_response[:q]).to eq("salt lake city")

    expect(book_response).to have_key(:docs)
    expect(book_response[:docs]).to be_a Array
    expect(book_response[:docs].count).to eq(3)

    expect(book_response[:docs][0]).to be_a Hash

    expect(book_response[:docs][0]).to have_key(:publisher)
    expect(book_response[:docs][0][:publisher]).to eq(["N. Doubleday"])

    expect(book_response[:docs][0]).to have_key(:title)
    expect(book_response[:docs][0][:title]).to eq(["Salt Lake City"])

    expect(book_response[:docs][0]).to_not have_key(:isbn) #first book has no isbn, but second one does. 

    expect(book_response[:docs][1]).to have_key(:isbn)
    expect(book_response[:docs][1][:isbn]).to eq(["9780822209829", "0822209829"])
  end
end