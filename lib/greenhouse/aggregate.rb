module Greenhouse
  class Aggregate

    Struct.new('Report', :light, :humidity, :temperature, :count)

    def initialize(path)
      @path = path
    end

    def ave_light
      report.light / report.count
    end

    def ave_humidity
      report.humidity / report.count
    end

    def ave_temperature
      report.temperature / report.count
    end

    def light
      report.light
    end

    def humidity
      report.humidity
    end

    def temperature
      report.temperature
    end

    def count
      report.count
    end

    def write
      File.open(aggregate_path, 'w') do |f|
        f.write YAML::dump({
          light: light,
          temperature: temperature,
          humidity: humidity,
          count: count
        })
      end
    end

    private

    def report
      @report ||= report_from_file || calculate_report
    end

    def aggregate_path
      date = /\d{4}_\d{2}_\d{2}/.match(@path)
      "#{BASE_DATA_PATH}/aggregates/#{date}.yml"
    end

    def full_path
      date = /\d{4}_\d{2}_\d{2}/.match(@path)
      "#{BASE_DATA_PATH}/#{date}.yml"
    end

    def report_from_file
      if File.exist?(aggregate_path)
        hash = YAML.load_file(aggregate_path)
        struct = Struct::Report.new
        struct.light = hash[:light]
        struct.humidity = hash[:humidity]
        struct.temperature = hash[:temperature]
        struct.count = hash[:count]
        struct
      end
    end

    def calculate_report
      struct = Struct::Report.new
      struct.light, struct.humidity, struct.temperature, struct.count = 0,0,0,0
      YAML.load_file(full_path).each_with_object(struct) do | hash, struct |
        struct.light += hash[:light]
        struct.humidity += hash[:humidity]
        struct.temperature += hash[:temperature]
        struct.count += 1
      end
      struct
    end

  end
end
