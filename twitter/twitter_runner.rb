require 'simple_worker'
require 'yaml'
require 'active_support/core_ext'

require_relative "twitter_worker"

config_data = YAML.load_file('../_config.yml')

SimpleWorker.configure do |config|
  config.project_id = config_data['sw']['project_id']
  config.token = config_data['sw']['token']
end

worker = TwitterWorker.new
worker.twitter_config = {
    :consumer_key => config_data['twitter']['consumer_key'],
    :consumer_secret => config_data['twitter']['consumer_secret'],
    :oauth_token => config_data['twitter']['oauth_token'],
    :oauth_token_secret => config_data['twitter']['oauth_token_secret']
}
worker.message = config_data['twitter']['oauth_token_secret']

worker.queue(:priority => 2)

worker.schedule(:start_at => 1.minutes.from_now,
           :run_every => 60, # seconds
           :run_times => 3,
           :priority => 2)