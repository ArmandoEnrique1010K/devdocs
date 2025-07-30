module Docs
  class Tonejs
    class EntriesFilter < Docs::EntriesFilter
      def call
        entries << {
          name: 'Tone.js API',
          type: 'Guide',
          path: file.path
        }
      end
    end
  end
end
