module Tonejs
  class CleanHtml < Docs::Filter
    def call
      # Aquí puedes limpiar el HTML: eliminar menús, footers, etc.
      # at_css("header")&.remove
      doc
    end
  end
end
