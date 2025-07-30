# Esta clase representa el doc "Tone.js" dentro del sistema
module Docs
  class Tonejs
    self.name = 'Tonejs'
    self.slug = 'tonejs'
    # self.repo = 'Tonejs/Tone.js'

    def initialize
      @root_path = 'public/docs/tonejs'
    end

    def index
      doc 'Tone.js Documentation', 'index.html'
    end
  end
end
