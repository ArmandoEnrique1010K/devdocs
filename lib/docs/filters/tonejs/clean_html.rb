module Docs
  class Tonejs
    class CleanHtmlFilter < Filter
      def call
        # Limpia etiquetas innecesarias y agrega IDs a títulos
        at_css('header')&.remove
        at_css('footer')&.remove
        doc.css('h1, h2, h3').each do |heading|
          heading['id'] = heading.text.parameterize
        end
      end
    end
  end
end
