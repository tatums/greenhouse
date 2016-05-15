module Greenhouse
  class Record

    def initialize(data)
      @data = data
    end

    def self.all
      Dir.glob("/home/pi/data/*.yml").map do |str|
        /\d{4}_\d{2}_\d{2}/.match(str).to_s
      end.sort
    end

    def self.find(date)
      path = "#{BASE_DATA_PATH}/#{date}.yml"
      YAML.load_file(path)
    end

    def as_hash
      {
        temperature: temperature, 
        humidity: humidity,
        light: light,
        time: Time.now.utc.iso8601
      }
    end

    def temperature
      (json['temperature'].to_i * 1.8) + 32
    end

    def humidity
      json['humidity'].to_i
    end

    def light
      json['light'].to_i
    end

    def valid?
      keys_present? && values_present?
    end

    private

      def keys_present?
        json.key?("temperature") && json.key?("humidity") && json.key?("light")
      end

      def values_present?
        (temperature != 32 && humidity != 0 && light >= 0)
      end

      def json
        @json ||= begin
                    JSON.parse(@data)
                  rescue JSON::ParserError => e
                    {}
                  end   
      end

  end
end
