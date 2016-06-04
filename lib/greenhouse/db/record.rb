module Greenhouse
  module DB
    class Record

      Struct.new('Item', :id, :recorded_at, :temperature, :light, :humidity, :created_at)

      def self.find(date)
        d = Time.parse(date.gsub('_', '-'))
        sd = Date.new(d.year, d.month, d.day)
        ed = Date.new(d.year, d.month, d.day + 1)
        start_date = Greenhouse.from_utc_to_zone(Time.parse(sd.to_s).to_s).utc.iso8601
        end_date = Greenhouse.from_utc_to_zone(Time.parse(ed.to_s).to_s).utc.iso8601

        db = SQLite3::Database.new("#{BASE_DATA_PATH}/../greenhouse.db")
        columns, *rows = db.execute2("SELECT * 
                             FROM records 
                             WHERE time BETWEEN '#{start_date}' AND '#{end_date}' ORDER BY time ASC")
        rows.map do |row| 
          recorded_at = Greenhouse.to_zone(row[1]).utc.iso8601
          created_at = Greenhouse.to_zone(row[5]).utc.iso8601
          row[1] = recorded_at
          row[5] = created_at 
          Hash[*columns.zip(row).flatten] 
        end
      end

    end
  end
end
