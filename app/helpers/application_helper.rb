module ApplicationHelper

def current_user
      @current_user ||= Facebook.find(session[:current_user])
    rescue ActiveRecord::RecordNotFound
      nil
end
    
def authenticated?
      !current_user.blank?
end
    
end
