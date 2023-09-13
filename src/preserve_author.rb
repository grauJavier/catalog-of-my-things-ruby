require 'json'
require_relative 'author'

class PreserveAuthor
  def gets_authors
    return unless File.exist?('./src/author.json')

    authors = []
    file = File.read('./src/author.json')
    authors_data = JSON.parse(file)
    authors_data['authors'].each do |author_name|
      authors << Author.new(author_name)
    end
    authors
  end

  def save_authors(authors)
    return if authors.empty?

    authors_data = { authors: authors.map(&:author_name) }
    File.open('./src/genres.json', 'w') do |file|
      file.puts(JSON.generate(authors_data))
    end
  end
end
