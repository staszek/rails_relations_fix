# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rails_relations_fix}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stanis\305\202aw Kolarzowski"]
  s.date = %q{2010-02-15}
  s.description = %q{Fix for 2 rails bugs. #3005 Counter_cache and polymorhic association. #???? Not refreshing association after destroy}
  s.email = %q{stanislaw.kolarzowski@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/rails_relations_fix.rb",
     "lib/rails_relations_fix/association.rb",
     "lib/rails_relations_fix/counter_cache.rb",
     "rails_relations_fix.gemspec",
     "test/helper.rb",
     "test/test_rails_relations_fix.rb"
  ]
  s.homepage = %q{http://github.com/staszek/rails_relations_fix}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Fix for 2 rails bugs}
  s.test_files = [
    "test/helper.rb",
     "test/test_rails_relations_fix.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
  end
end
