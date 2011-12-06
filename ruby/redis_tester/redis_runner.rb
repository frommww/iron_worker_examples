require "iron_worker"
require "yaml"

require_relative "redis_worker"

config_data = YAML.load_file("../_config.yml")

IronWorker.configure do |config|
  config.project_id = config_data['sw']['project_id']
  config.token = config_data['sw']['token']
end

worker = RedisWorker.new
worker.redis_connection = config_data['redis_uri']

#worker.run_local

worker.queue
#worker.wait_until_complete
#puts worker.log

