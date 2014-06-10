# -*- encoding: utf-8 -*-
# stub: ocra 1.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "ocra"
  s.version = "1.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Lars Christensen"]
  s.date = "2013-03-29"
  s.description = "OCRA (One-Click Ruby Application) builds Windows executables from Ruby\nsource code. The executable is a self-extracting, self-running\nexecutable that contains the Ruby interpreter, your source code and\nany additionally needed ruby libraries or DLL."
  s.email = "larsch@belunktum.dk"
  s.executables = ["ocra"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "README.rdoc", "bin/ocra"]
  s.homepage = "http://ocra.rubyforge.org"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.rubyforge_project = "ocra"
  s.rubygems_version = "2.2.2"
  s.summary = "OCRA (One-Click Ruby Application) builds Windows executables from Ruby source code"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_development_dependency(%q<hoe>, ["~> 3.5"])
    else
      s.add_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_dependency(%q<hoe>, ["~> 3.5"])
    end
  else
    s.add_dependency(%q<rdoc>, ["~> 3.10"])
    s.add_dependency(%q<hoe>, ["~> 3.5"])
  end
end
