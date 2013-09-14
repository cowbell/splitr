class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CurrentUser

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end unless Rails.env.test?
end
