module Docs
  class Tonejs < Docs::FileScraper
    self.name = 'Tone.js'
    self.slug = 'tonejs'
    self.type = 'javascript'
    # self.source = 'https://tonejs.github.io/docs/'
    # self.root_path = 'docs/tonejs'  # Directorio local donde están los archivos HTML


    html_filters.push 'tonejs/entries', 'tonejs/clean_html'
  end
end

