class Configuration
  class << self
    @values = Hash.new
    def [](key)
      @values[key]
    end
    def []=(key, value)
      @values[:key] = value
    end
  end
end