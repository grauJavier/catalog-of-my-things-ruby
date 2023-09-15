require 'json'
require_relative 'source'

class PreserveSources
  def gets_sources
    return [] unless File.exist?('./src/sources.json')

    sources = []
    file = File.read('./src/sources.json')
    return [] if file.empty?

    sources_data = JSON.parse(file)
    sources_data['sources'].each do |source_name|
      sources << Source.new(source_name)
    end
    sources
  end

  def save_sources(sources)
    return if sources.empty?

    sources_data = { sources: sources.map(&:source_name) }
    File.open('./src/sources.json', 'w') do |file|
      file.puts(JSON.generate(sources_data))
    end
  end
end
