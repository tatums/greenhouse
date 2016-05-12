module Greenhouse
  class FileName

    def self.path
      path = "#{BASE_PATH}/../data/#{Time.now.strftime('%Y_%m_%d')}.yml"
      FileUtils.touch(path) unless File.exists?(path)
      return path
    end

  end
end
