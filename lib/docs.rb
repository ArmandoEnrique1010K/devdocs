require 'bundler/setup'
Bundler.require :default, :docs

require 'active_support'
require 'active_support/core_ext'
I18n.enforce_available_locales = true

module Docs
  require 'docs/core/autoload_helper'
  extend AutoloadHelper

  mattr_reader :root_path
  @@root_path = File.expand_path '..', __FILE__

  autoload :URL, 'docs/core/url'
  autoload_all 'docs/core'
  autoload_all 'docs/filters/core', 'filter'
  autoload_all 'docs/scrapers'
  autoload_all 'docs/storage'
  autoload_all 'docs/subscribers'

  mattr_accessor :store_class
  self.store_class = FileStore

  mattr_accessor :store_path
  self.store_path = File.expand_path '../public/docs', @@root_path

  mattr_accessor :rescue_errors
  self.rescue_errors = false

  class DocNotFound < NameError; end
  class SetupError < StandardError; end

  def self.all
    Dir["#{root_path}/docs/scrapers/**/*.rb"].
      map { |file| File.basename(file, '.rb') }.
      map { |name| const_get(name.camelize) }.
      sort { |a, b| a.name.casecmp(b.name) }.
      reject(&:abstract)
  end

  def self.all_versions
    all.flat_map(&:versions)
  end

  def self.defaults
    %w(css dom html http javascript).map(&method(:find))
  end

  def self.installed
    Dir["#{store_path}/**/index.json"].
      map { |file| file[%r{/([^/]*)/index\.json\z}, 1] }.
      sort!.
      map { |path| all_versions.find { |doc| doc.path == path } }.
      compact
  end

  def self.find(name, version = nil)
    const = name.camelize
    doc = const_get(const)

    if version.present?
      doc = doc.versions.find { |klass| klass.version == version || klass.version_slug == version }
      raise DocNotFound.new(%(could not find version "#{version}" for doc "#{name}"), name) unless doc
    elsif version != false
      doc = doc.versions.first
    end

    doc
  rescue NameError => error
    if error.name.to_s == const
      raise DocNotFound.new(%(could not find doc "#{name}"), name)
    else
      raise error
    end
  end

  def self.find_by_slug(slug, version = nil)
    doc = all.find { |klass| klass.slug == slug }

    unless doc
      raise DocNotFound.new(%(could not find doc with "#{slug}"), slug)
    end

    if version.present?
      version = doc.versions.find { |klass| klass.version == version || klass.version_slug == version }
      raise DocNotFound.new(%(could not find version "#{version}" for doc "#{doc.name}"), doc.name) unless version
      doc = version
    end

    doc
  end

  def self.generate_page(name, version, page_id)
    find(name, version).store_page(store, page_id)
  end

  def self.generate(doc, version = nil)
    doc = find(doc, version) unless doc.respond_to?(:store_pages)
    doc.store_pages(store)
  end

  def self.generate_manifest
    Manifest.new(store, all_versions).store
  end

  def self.store
    store_class.new(store_path)
  end

  def self.aliases
    {
      'angular' => 'ng',
      'angular.js' => 'ng',
      'backbone' => 'bb',
      'cpp' => 'c++',
      'coffeescript' => 'cs',
      'crystal' => 'cr',
      'elixir' => 'ex',
      'javascript' => 'js',
      'julia' => 'jl',
      'jquery' => '$',
      'knockout' => 'ko',
      'kubernetes' => 'k8s',
      'less' => 'ls',
      'lodash' => '_',
      'love' => 'löve',
      'marionette' => 'mn',
      'markdown' => 'md',
      'matplotlib' => 'mpl',
      'modernizr' => 'mdr',
      'moment' => 'mt',
      'openjdk' => 'java',
      'nginx' => 'ngx',
      'numpy' => 'np',
      'pandas' => 'pd',
      'postgresql' => 'pg',
      'python' => 'py',
      'rails' => 'ror',
      'ruby' => 'rb',
      'rust' => 'rs',
      'sass' => 'scss',
      'tensorflow' => 'tf',
      'typescript' => 'ts',
      'underscore.js' => '_',
    }
  end

  extend Instrumentable

  def self.install_report(*names)
    names.each do |name|
      const_get("#{name}_subscriber".camelize).subscribe_to(self)
    end
  end
end

# # require_relative 'docs/base'

# # Incluir el archivo de filtros y el scraper
# require_relative "docs/tonejs"
# require_relative "docs/filters/tonejs"
# # require_relative 'filters/tonejs'

# # Registrar correctamente los filtros dentro del namespace Docs::Tonejs:
# register "Tone.js", :tonejs, {
#   base_url: "file:///#{Dir.pwd}/docs/tonejs/",
#   root_path: "index.html",
#   files: "**/*.html",
#   filter: [
#     Docs::Tonejs::CleanHtml,  # <- CORRECTO: Dentro del namespace Docs
#     Docs::Tonejs::Entries
#   ],
#   parser: :html,
#   search_index: true
# }
