Gem::Specification.new do |s|
  s.name = "haml-underscore-template"
  s.version = "0.1.0"
  s.summary = "Haml+Underscore Template compiler"
  s.description = "Compile and evaluate underscore templates from Ruby."

  s.files = Dir["README.md", "LICENSE", "lib/**/*.rb"]

  s.add_dependency 'sprockets', '~> 2.12.0'
  s.add_dependency 'haml'
  s.add_development_dependency "execjs", "~> 1.4.0"
  s.add_development_dependency "json", "~> 1.7.7"

  s.authors = ["Christopher Rueber", "Jean-Sébastien Ney"]
  s.email = ["crueber@gmail.com"]
  s.homepage = "https://github.com/crueber/haml-underscore-template/"
end
