# -*- coding: utf-8 -*-

class Cacherite
  attr_accessor :lifetime

  def initialize(directory)
    @directory = File.expand_path(directory)
    @lifetime = 3600
  end

  def get(key)
    begin
      cache = open(File.join(@directory, key)).read
      if Time.now - File::Stat.new(File.join(@directory, key)).mtime >= @lifetime && @lifetime != 0
        self.remove(key)
        nil
      else
        @key = key
        cache
      end
    rescue Errno::ENOENT
      nil
    end
  end

  def save(key, content)
    cache = File.open(File.join(@directory, key), "w")
    cache.write(content)
    cache.close

    true
  end

  def remove(key)
    FileUtils.rm(File.join(@directory, key))
  end

  def clean
    FileUtils.rm(Dir.glob(File.join(@directory, "*")))
  end

  def extend_life(key = @key)
    begin
      FileUtils.touch(File.join(@directory, key))
    rescue TypeError
      raise "key has not been set or is not get"
    end

    File::Stat.new(File.join(@directory, key)).mtime
  end
end
