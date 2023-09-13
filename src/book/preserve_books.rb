require 'json'

class PreserveBooks
  def gets_books
    return unless File.exist?('./src/book/books.json')

    saved_books = []
    file = File.read('./src/book/books.json')
    data_hashes = JSON.parse(file)
    data_hashes.each do |book|
      saved_books << Book.from_hash(book)
    end
    saved_books
  end

  def save_books(books)
    return if books.empty?

    data_hashes = books.map(&:to_hash)
    File.write('./src/book/books.json', JSON.pretty_generate(data_hashes))
  end
end
