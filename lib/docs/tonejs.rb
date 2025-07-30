module Docs
  class Tonejs < Docs::FileScraper
    self.name = 'Tone.js'
    self.slug = 'tonejs'
    self.type = 'javascript'

    def initialize
      @root_path = 'docs/tonejs'
    end

    filter 'tonejs/clean_html'
    filter 'tonejs/entries'

    def index
      doc 'Tone.js Documentation', 'index.html'
    end
  end
end
