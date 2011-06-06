# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{polecat}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gibheer"]
  s.date = %q{2011-06-06}
  s.description = %q{This is a search library for searching terms in documents}
  s.email = %q{gibheer@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/polecat.rb",
    "lib/polecat/document.rb",
    "lib/polecat/document_resource.rb",
    "lib/polecat/index_reader.rb",
    "lib/polecat/index_searcher.rb",
    "lib/polecat/index_writer.rb",
    "lib/polecat/query.rb",
    "lib/polecat/term.rb",
    "polecat.gemspec",
    "spec/index_reader/locked_spec.rb",
    "spec/index_reader/new_spec.rb",
    "spec/index_reader/read_spec.rb",
    "spec/index_searcher/new_spec.rb",
    "spec/index_searcher/search_spec.rb",
    "spec/index_writer/add_spec.rb",
    "spec/index_writer/count_spec.rb",
    "spec/index_writer/create_reader_spec.rb",
    "spec/index_writer/new_spec.rb",
    "spec/index_writer/write_spec.rb",
    "spec/polecat_spec.rb",
    "spec/query/add_spec.rb",
    "spec/query/new_spec.rb",
    "spec/spec_helper.rb",
    "spec/term/new_spec.rb"
  ]
  s.homepage = %q{http://github.com/Gibheer/polecat}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.10}
  s.summary = %q{library for searching through documents}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<reek>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<reek>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<reek>, [">= 0"])
  end
end

