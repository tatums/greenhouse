require_relative "greenhouse/version"
require_relative "greenhouse/file_name"
require_relative "greenhouse/record"
require_relative "greenhouse/aggregate"

require "yaml"
require "time"
require "fileutils"
require "json"
require "pry"

module Greenhouse
  BASE_PATH = "/home/pi/greenhouse"
  BASE_DATA_PATH = "/home/pi/data"
  TIME_ZONE = "CDT"

  def self.to_zone(date_string)
    t = Time.parse(date_string)
    t + Time.zone_offset(TIME_ZONE)
  end
end
