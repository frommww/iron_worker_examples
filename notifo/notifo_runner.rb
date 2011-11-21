require "simple_worker"
require 'yaml'

require_relative "notifo_worker.rb"

config_data = YAML.load_file('../_config.yml')

SimpleWorker.configure do |config|
  config.project_id = config_data['sw']['project_id']
  config.token = config_data['sw']['token']
end

worker = NotifoWorker.new
worker.service_user = config_data['notifo']['service_user']
worker.service_key = config_data['notifo']['service_key']
worker.task = config_data['notifo']['task'].to_sym
worker.username = config_data['notifo']['username']
worker.message = config_data['notifo']['message']

worker.run_local

#worker.queue
#worker.wait_until_complete
#puts worker.log
