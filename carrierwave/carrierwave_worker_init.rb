require 'yaml'
require 'carrierwave'
require 'fog'

require_relative 'sample_uploader'
require_relative 'carrierwave_configure'

conf = YAML.load_file 'carrierwave.yml'
carrierwave_configure(conf['aws']['access_key'], conf['aws']['secret_key'], conf['aws']['bucket'])

uploader = SampleUploader.new
uploader.store!(File.new(conf['file_name']))

File.open("look-at-me.html", "w") do |f|
  f.puts "<img src=\"#{uploader.url}\" />"
end

puts "now open look-at-me.html in browser"
