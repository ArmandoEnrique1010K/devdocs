# Esto crea el módulo Docs::Tonejs y define la clase Entries dentro de él.
module Docs
  module Tonejs
    class Entries < Docs::EntriesFilter
      # aquí el contenido
      # def self.root
      #   Path.root.join('tonejs')
      # end

      def get_name
        at_css("h1, h2")&.text
      end
    end
  end
end
