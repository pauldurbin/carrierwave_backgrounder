# encoding: utf-8
module CarrierWave
  module Workers

    class RemoveTempDirectoryWorker
      include Sidekiq::Worker
      
      def perform(record, column)
        asset, asset_tmp = record.send(:"#{column}"), record.send(:"#{column}_tmp")
  
        File.expand_path(asset.cache_dir, asset.root).tap do |cache_dir|
          File.join(cache_directory, asset_tmp.split("/").first).tap do |temp_dir|
            FileUtils.rm_r(temp_dir, :force => true) if File.directory?(temp_dir)
          end
        end
      end
    end # Perform

  end # Workers
end # Backgrounder
