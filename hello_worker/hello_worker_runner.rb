require 'yaml'
require 'simple_worker'
require_relative "hello_worker.rb"

# Create a project at SimpleWorker.com and enter your credentials below
# Configuration method of v2 of SimpleWorker gem
# See the Projects tab for PROJECT_ID and Accounts/API Tokens tab for TOKEN
#-------------------------------------------------------------------------
config_data = YAML.load_file('../_config.yml')

SimpleWorker.configure do |config|
  config.project_id = config_data["sw"]["project_id"]
  config.token = config_data["sw"]["token"]
end

# Configuration for v1 of SimpleWorker gem
#-------------------------------------------------------------------------
#SimpleWorker.configure do |config|
#  config.access_key = 'SIMPLEWORKER_ACCESS_KEY'
#  config.secret_key = 'SIMPLEWORKER_SECRET_KEY'
#end
#-------------------------------------------------------------------------

# Create and queue the first worker (several times) with an arbitrary parameter
worker = HelloWorker.new
worker.some_param = "Passing in parameters is easy!"
10.times do
  worker.queue
end

# Create and queue the second worker, this time in the highest priority queue.
worker2 = HelloWorker.new
worker2.some_param = "I am running at the highest priority."

# Now let's create a third worker and schedule it to run in 3 minutes, every minute, 5 times.
# For the pretty time syntax, we need portions of active_support
require "active_support/core_ext"

worker3 = HelloWorker.new
worker3.some_param = "I should be scheduled to run at a later time."
worker3.schedule(:start_at => 3.minutes.since, :run_every => 60, :run_times => 5)

# That's it. Easy to use but lots of power to run 10/100/1000s of tasks
puts "\nCongratulations you've just queued and scheduled workers in the SimpleWorker cloud!\n\n"
puts "Now go to SimpleWorker.com to view all your jobs running!\n\n"


# You can even run the worker locally if you want.
#-----------------------------------------------------------------------------------------------------#
#worker4 = HelloWorker.new
#worker4.some_param = "Running this task locally"
#worker4.run_local


# Here's how you can check the status from inside your runner if you want to.
#-----------------------------------------------------------------------------------------------------#
def self.wait_for_task(params={})
  tries  = 0
  status = nil
  sleep 1
  while tries < 60
    status = status_for(params)
    puts 'status = ' + status.inspect
    if status["status"] == "complete" || status["status"] == "error"
      break
    end
    sleep 2
  end
  status
end

def self.status_for(ob)
  if ob.is_a?(Hash)
    ob[:schedule_id] ? WORKER.schedule_status(ob[:schedule_id]) : WORKER.status(ob[:task_id])
  else
    ob.status
  end
end

# If you want your runner to check and display the status of your worker, simply uncomment the next 3 lines.
#puts "\nLet's have the runner (this file) check the status until the workers are complete.\n"
#status = wait_for_task(worker)
#status2 = wait_for_task(worker2)
