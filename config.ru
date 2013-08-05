require ::File.expand_path("../config/environment",  __FILE__)
use Rack::Deflater
run Rails.application
