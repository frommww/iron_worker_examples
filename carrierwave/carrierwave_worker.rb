require 'simple_worker'

class CarrierWaveWorker < SimpleWorker::Base
  require 'RMagick' # it's available at SimpleWorker servers

  merge_gem 'carrierwave'
  # if you need ActiveRecord support, use following line instead
  # merge_gem 'carrierwave', :require => ['carrierwave', 'carrierwave/orm/activerecord']

  merge_gem 'fog'

  merge 'sample_uploader'
  merge 'carrierwave_configure'

  attr_accessor :aws_access_key
  attr_accessor :aws_secret_key
  attr_accessor :aws_bucket
  attr_accessor :file_name

  def run
    carrierwave_configure(@aws_access_key, @aws_secret_key, @aws_bucket)
    uploader = SampleUploader.new

    uploader.retrieve_from_store!(@file_name)
    uploader.cache_stored_file!

    i = Magick::ImageList.new(uploader.file.path)
    ri = i.rotate(90)
    ri.write(@file_name)

    uploader.store!(File.new(@file_name))
  end
end
