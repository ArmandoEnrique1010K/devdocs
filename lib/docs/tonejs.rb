# Esta clase representa el doc "Tone.js" dentro del sistema
module Docs
  class Tonejs < Docs::Base
    self.name = 'Tone.js'
    self.slug = 'tonejs'
    # self.repo = 'Tonejs/Tone.js'

    def initialize
      @root_path = 'docs/tonejs'
    end

    def index
      doc 'Tone.js Documentation', 'index.html'
    end
  end
end
