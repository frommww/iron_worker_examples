require 'simple_worker'
require 'yaml'

require_relative 'simpledb_test_worker'

config_data = YAML.load_file '../_config.yml'

SimpleWorker.configure do |config|
  config.project_id = config_data['sw']['project_id']
  config.token = config_data['sw']['token']
end

worker = SimpleDBTestWorker.new
worker.aws_access = config_data['aws']['access_key']
worker.aws_secret = config_data['aws']['secret_key']

#worker.run_local
worker.queue(:priority => 2)
status = worker.wait_until_complete
puts worker.get_log
