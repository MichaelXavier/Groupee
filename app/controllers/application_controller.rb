class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  before_filter :set_default_user

private
  def set_default_user
    @current_user = User.find_by_email('f.kong@funkysflights.com')
  end
end
