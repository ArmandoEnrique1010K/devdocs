# Define el módulo Tonejs dentro del namespace Docs para evitar conflictos de constantes
module Docs
  module Tonejs
    class CleanHtml
      def self.call(html)
        # Se deja en blanco porque los archivos HTML ya estan limpios

        # Aquí puedes limpiar el HTML: eliminar menús, footers, etc.
        # at_css("header")&.remove
        html
      end
    end
  end
end
