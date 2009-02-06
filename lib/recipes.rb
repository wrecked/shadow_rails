Dir.glob(File.join(File.dirname(__FILE__), 'recipes', '*.rb')).each do |recipe|
  require recipe
end