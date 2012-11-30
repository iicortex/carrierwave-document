require 'docsplit'
require 'carrierwave'
require 'carrierwave/document/docsplite_options'

module CarrierWave
  module Document
    extend ActiveSupport::Concern

    module ClassMethods

      def thumbnail options = {}
        process thumbnail: options
      end

      def covert_to_pdf options = {}
        process covert_to_pdf: options
      end

      #      def extract_images options = {}
      #        process extract_images: options
      #      end
    end

    def thumbnail options = {}
      cache_stored_file! if !cached?

      @options = CarrierWave::Document::DocspliteOptions.new(options)
     
      tmp_path = File.dirname(current_path)
  
      with_trancoding_callbacks do
        Docsplit.extract_images(current_path, :size => @options.size, :format => @options.format, :pages => 1, :output => tmp_path)
        File.rename File.join( File.dirname(current_path), "#{file.basename}_1.#{@options.format}" ), current_path
      end
    end

    def covert_to_pdf options = {}
      cache_stored_file! if !cached?
      
      tmp_path = File.dirname(current_path) 
      @options = CarrierWave::Document::DocspliteOptions.new(options)
   
      with_trancoding_callbacks do
        if file.content_type != "application/pdf"
          Docsplit.extract_pdf(current_path, :output => tmp_path)
          File.rename File.join(File.dirname(current_path), "#{file.basename}.pdf"), current_path
        end
      end
    end

    #    def extract_images options = {}
    #      cache_stored_file! if !cached?
    #
    #      tmp_path =  File.join( File.dirname(current_path), file.basename )
    #      @options = CarrierWave::Doc::DocspliteOptions.new(options)
    #
    #      with_trancoding_callbacks do
    #        Docsplit.extract_images(current_path, :size => @options.size, :format => @options.format, :output => tmp_path)
    #        File.delete(current_path)
    #      end
    #    end

    private
    def with_trancoding_callbacks(&block)
      callbacks = @options.callbacks
      begin
        send_callback(callbacks[:before_transcode])
        block.call
        send_callback(callbacks[:after_transcode])
      rescue => e
        send_callback(callbacks[:rescue])
      
        raise CarrierWave::ProcessingError.new("Failed to transcode with Docsplit. Check docsplit install and verify document is not corrupt or cut short. Original error: #{e}")
      ensure
        send_callback(callbacks[:ensure])
      end
    end

    def send_callback(callback)
      model.send(callback, @options.format, @options.raw) if callback.present?
    end

  end
end