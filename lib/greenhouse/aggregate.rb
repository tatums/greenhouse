module Greenhouse
  class Aggregate

    Struct.new('Report', :light, :humidity, :temperature, :count)

    def initialize(path)
      @path = path
    end

    def run
      report = Struct::Report.new
      report.light = 0
      report.humidity = 0
      report.temperature = 0
      report.count = 0
    
      #data = File.exist?(@path)
      YAML.load_file(full_path).each_with_object(report) do | hash, report |
        report.light += hash[:light]
        report.humidity += hash[:humidity]
        report.temperature += hash[:temperature]
        report.count += 1
      end

      puts "light: #{report.light / report.count}"
      puts "humidity: #{report.humidity / report.count}"
      puts "temperature: #{report.temperature / report.count}"
      puts report
    end

    private


    def create_aggregate_yaml(path)
      puts "Create #{path}"
      #FileUtils.touch(path)
    end

    def full_path
      date = /\d{4}_\d{2}_\d{2}/.match(@path)
      "#{BASE_PATH}/data/#{date}.yml"
    end

  end
end
