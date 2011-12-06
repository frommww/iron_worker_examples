require 'iron_worker'
require 'yaml'

load 'mailer_worker.rb'

config_data = YAML.load_file('../_config.yml')

IronWorker.configure do |config|
  config.project_id = config_data["sw"]["project_id"]
  config.token = config_data["sw"]["token"]
end

worker = MailerWorker.new
worker.gmail_user_name = config_data["gmail"]["user_name"]
worker.gmail_password = config_data["gmail"]["password"]
worker.email_send_to = config_data["email"]["to"]
worker.queue(:priority=>1)
