class CommonController < ApplicationController
  before_filter :require_no_user, :only => [:home, :tos]
  
  def home
    @user_session = UserSession.new
  end
  
  def terms_of_service
    
  end
end
