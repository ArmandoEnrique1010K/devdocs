module Docs
  class Tonejs < Docs::FileScraper
    self.name = 'Tone.js'
    self.slug = 'tonejs'
    self.type = 'javascript'
    # self.source = 'public/docs/tonejs'
    # self.root_path = 'public/docs/tonejs'  # Directorio local donde están los archivos HTML


    html_filters.push 'tonejs/entries', 'tonejs/clean_html'
  end
end

