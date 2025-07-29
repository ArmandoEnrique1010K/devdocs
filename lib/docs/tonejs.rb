module Docs
  class Tonejs < Docs::Bash
    self.name = 'Tone.js'
    self.slug = 'tonejs'
    # self.repo = 'Tonejs/Tone.js'

    # Ubicación hacia la carpeta de tonejs
    def initialize
      @root_path = 'public/docs/tonejs'
    end

    def index
      doc 'Tone.js Documentation', 'index.html'
    end
  end
end
