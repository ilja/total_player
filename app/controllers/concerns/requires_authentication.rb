module RequiresAuthentication
  extend ActiveSupport::Concern

  included do
    before_filter :require_authentication
  end

  def require_authentication
    redirect_to '/auth/identity', :notice => "Please sign in." unless session[:user_id].present?
  end
end