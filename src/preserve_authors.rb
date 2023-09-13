require 'json'
require_relative 'author'

class PreserveAuthors
  def gets_authors
    return [] unless File.exist?('./src/authors.json')

    authors = []
    file = File.read('./src/authors.json')
    authors_data = JSON.parse(file)

    authors_data['authors'].each do |author|
      authors << Author.new(author['first_name'], author['last_name'])
    end

    authors
  end

  def save_authors(authors)
    return if authors.empty?

    authors_data = { authors: authors.map { |author| { first_name: author.first_name, last_name: author.last_name } } }
    File.open('./src/authors.json', 'w') do |file|
      file.puts(JSON.generate(authors_data))
    end
  end
end
