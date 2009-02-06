class Configuration
  class << self
    
    def [](key)
      @values ||= Hash.new
      @values[key]
    end
    def []=(key, value)
      @values ||= Hash.new
      @values[key] = value
    end
  end
end