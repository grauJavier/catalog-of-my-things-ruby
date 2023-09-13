require 'json'
require_relative 'label'

class PreserveLabels
  def gets_labels
    return [] unless File.exist?('./src/labels.json')

    labels = []
    file = File.read('./src/labels.json')
    labels_data = JSON.parse(file)

    labels_data['labels'].each do |label|
      labels << Label.new(label['title'], label['color'])
    end

    labels
  end

  def save_labels(labels)
    return if labels.empty?

    labels_data = { labels: labels.map { |label| { title: label.title, color: label.color } } }
    File.open('./src/labels.json', 'w') do |file|
      file.puts(JSON.generate(labels_data))
    end
  end
end
