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
end
