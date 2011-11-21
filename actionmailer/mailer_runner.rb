require 'simple_worker'
require 'yaml'

load 'mailer_worker.rb'

config_data = YAML.load_file('../_config.yml')

SimpleWorker.configure do |config|
  config.project_id = config_data["project_id"]
  config.token = config_data["token"]
end

worker = MailerWorker.new
worker.gmail_user_name = config_data["gmail_user_name"]
worker.gmail_password = config_data["gmail_password"]
worker.email_send_to = config_data["email_send_to"]
worker.queue(:priority=>1)
