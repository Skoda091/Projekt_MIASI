# -*- encoding: utf-8 -*-
# stub: texplay 0.4.3 ruby lib
# stub: ext/texplay/extconf.rb

Gem::Specification.new do |s|
  s.name = "texplay"
  s.version = "0.4.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["John Mair (banisterfiend)"]
  s.date = "2012-07-15"
  s.description = "TexPlay is a light-weight image manipulation framework for Ruby and Gosu"
  s.email = ["jrmair@gmail.com"]
  s.extensions = ["ext/texplay/extconf.rb"]
  s.files = ["ext/texplay/extconf.rb"]
  s.homepage = "http://banisterfiend.wordpress.com/2008/08/23/texplay-an-image-manipulation-tool-for-ruby-and-gosu/"
  s.rubygems_version = "2.2.2"
  s.summary = "TexPlay is a light-weight image manipulation framework for Ruby and Gosu"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<gosu>, [">= 0.7.25"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_development_dependency(%q<rake-compiler>, [">= 0.7.9"])
    else
      s.add_dependency(%q<gosu>, [">= 0.7.25"])
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_dependency(%q<rake-compiler>, [">= 0.7.9"])
    end
  else
    s.add_dependency(%q<gosu>, [">= 0.7.25"])
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
    s.add_dependency(%q<rake-compiler>, [">= 0.7.9"])
  end
end
