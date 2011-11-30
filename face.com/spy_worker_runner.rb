require 'simple_worker'
require 'yaml'

SETTINGS = YAML.load_file('../_config.yml')
SimpleWorker.configure do |config|
  config.project_id = SETTINGS["sw"]["project_id"]
  config.token = SETTINGS["sw"]["token"]
end
load "spy_worker.rb"
tw_username       = "mrskutcher"
fw                = SpyWorker.new
fw.rss_feed       = "http://twitpic.com/photos/#{tw_username}/feed.rss"
fw.api_key        = SETTINGS["face"]["api_key"]
fw.api_secret     = SETTINGS["face"]["api_secret"]
fw.email_username = SETTINGS["email"]["username"]
fw.email_password = SETTINGS["email"]["password"]
fw.email_domain   = SETTINGS["email"]["domain"]
fw.send_to        = "user@email.com"
fw.title          = "Rss feed of #{tw_username}"
require 'active_support/core_ext'
fw.last_date      = 1.years.ago
fw.queue