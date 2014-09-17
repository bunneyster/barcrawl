class CrashController < ApplicationController
  before_action :bounce_if_not_admin
  
  # GET /crash/crash
  def crash
    raise Exception, "This is a crash handling test."
  end
end
