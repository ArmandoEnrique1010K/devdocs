module Tonejs
  class Entries < Docs::EntriesFilter
    # Extracción de titulos
    def get_name
      at_css("h1, h2")&.text
    end
  end
end
