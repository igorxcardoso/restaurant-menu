namespace :import do
  desc "Import restaurants/menus/menu_items from JSON file"
  task from_file: :environment do
    path = ENV['FILE'] || ENV['PATH_TO_FILE'] || ENV['PATH']

    unless path && File.exist?(path)
      puts "Usage: rake import:from_file FILE=/path/to/file.json"
      exit 1
    end

    file_content = File.read(path, encoding: 'utf-8')
    payload = JSON.parse(file_content)
    result = JsonImporterService.new(payload).call

    puts "Success: #{result.success}"
    puts "Logs:"
    puts result.logs.inspect
  rescue JSON::ParserError => e
    puts "Failed to parse JSON: #{e.message}"
  rescue => e
    puts "Error: #{e.class} - #{e.message}"
  end
end
