source "https://rubygems.org"

ruby "2.0.0"

gem "rails", "4.0.0"

gem "bcrypt-ruby", "~> 3.0.0"
gem "cancan"
gem "coffee-rails"
gem "foreman", require: false
gem "jquery-rails"
gem "pg"
gem "turbolinks"
gem "uglifier"

group :production do
  gem "rails_12factor" # Heroku
  gem "unicorn", require: false
  gem "dalli"
  gem "memcachier"
end

group :test do
  gem "factory_girl_rails"
end

group :development, :test do
  gem "debugger"
end
