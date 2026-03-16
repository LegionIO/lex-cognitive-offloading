# frozen_string_literal: true

require_relative 'lib/legion/extensions/cognitive_offloading/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-cognitive-offloading'
  spec.version       = Legion::Extensions::CognitiveOffloading::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX Cognitive Offloading'
  spec.description   = 'Strategic externalization of cognitive tasks — offloading decisions, store trust, and retrieval tracking for brain-modeled agentic AI'
  spec.homepage      = 'https://github.com/LegionIO/lex-cognitive-offloading'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']        = spec.homepage
  spec.metadata['source_code_uri']     = 'https://github.com/LegionIO/lex-cognitive-offloading'
  spec.metadata['documentation_uri']   = 'https://github.com/LegionIO/lex-cognitive-offloading'
  spec.metadata['changelog_uri']       = 'https://github.com/LegionIO/lex-cognitive-offloading'
  spec.metadata['bug_tracker_uri']     = 'https://github.com/LegionIO/lex-cognitive-offloading/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir.glob('{lib,spec}/**/*') + %w[lex-cognitive-offloading.gemspec Gemfile]
  end
  spec.require_paths = ['lib']
  spec.add_development_dependency 'legion-gaia'
end
