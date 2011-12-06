# This worker simply calls back to a URL in your application. Great for performing some action
# on your application on a schedule

require 'iron_worker'
require 'httparty'
require 'active_record'

class CallbackWorker < IronWorker::Base

  attr_accessor :callback_url

  #Need to merge the model file if running outside rails
  #Models are merged automatically within rails
  merge "../models/user"

  def run

    @users = User.all

    @users.each do |user|
      log "posting to #{callback_url}?user_id=#{user.id}"
      HTTParty.post(hook_url, {:body=>{:user_id=>user.id}})
    end

  end

end
