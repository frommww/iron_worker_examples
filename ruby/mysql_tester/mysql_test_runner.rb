require 'iron_worker'
require 'yaml'

require_relative 'mysql_test_worker'

config_data = YAML.load_file('../_config.yml')

IronWorker.configure do |config|
  config.project_id = config_data['sw']['project_id']
  config.token = config_data['sw']['token']
end

worker = MySQLTestWorker.new 
worker.db_config = config_data['mysql']

#worker.run_local
worker.queue(:priority => 1)
