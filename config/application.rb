require File.expand_path("../boot", __FILE__)

require "rails/all"
Bundler.require(:default, Rails.env)

module Splitr
  class Application < Rails::Application
  end
end
