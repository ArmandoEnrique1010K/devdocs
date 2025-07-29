module Tonejs
  class Entries < Docs::EntriesFilter
    # Extracción de titulos
    def get_name
      at_css("h1, h2")&.text
    end

    # Este método ES OBLIGATORIO
    def get_type
      return unless file # seguridad ante archivos nulos

      path = file.sub(%r{^.*?/tonejs/}, "") # extrae la ruta relativa como "classes/Player.html"

      case path
      when %r{\Aclasses/}     then "Class"
      when %r{\Amodules/}     then "Module"
      when %r{\Ainterfaces/}  then "Interface"
      when %r{\Afunctions/}   then "Function"
      when %r{\Atypes/}       then "Type"
      when %r{\Avariables/}   then "Variable"
      else "Guide" # para index.html u otras páginas sueltas
      end
    end
  end
end
