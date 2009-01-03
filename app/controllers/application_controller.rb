# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  #before_filter :login_required
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '9de9a2c649e99532b96ed26c6cc55ba7'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  private
  helper_method :current_project
  def current_project
    project = Project.find(session[:project_id]) rescue Project.last
  end
  
  # returns true if there's a redirect
  def redirect_if_not_current_user(user_id)
    if user_id && user_id != current_user.id
      logout_killing_session!
      redirect_to login_path
      return true
    end
    false
  end
end
