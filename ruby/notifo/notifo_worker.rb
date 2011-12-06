require "simple_worker"

class NotifoWorker < SimpleWorker::Base

  merge_gem "notifo"

  attr_accessor :service_user, :service_key
  
  # These are dynamic, and will be different for each task
  attr_accessor :username, :message, :task

  # The SimpleWorker environment will invoke and run this def:
  def run
    begin
      log "connecting..."
      @notifo = Notifo.new(@service_user, @service_key)
      log "connected"
    
      if @task == :subscribe
        log "subscribing #{@username}"
        @notifo.subscribe(@username)
      else
        log "sending #{@message} to #{@username}"
        @notifo.post(@username, @message)
      end
    rescue => ex
      log "Exception: #{ex.message}"
      raise ex
    end
  end
end
