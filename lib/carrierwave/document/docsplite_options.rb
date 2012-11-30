module Carrierwave
  module Document
    class DocspliteOptions
      attr_reader :format, :size, :callbacks

      def initialize(options)
        @format = options[:format] || "png"
        @size = options[:size] || "640x360"
        @callbacks = options[:callbacks] || {}
        @unparsed = options
      end

      def raw
        @unparsed
      end

    end
  end
end
