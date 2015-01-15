source "https://rubygems.org"

ruby "2.2.0"

gem "rails", ">= 4.2.0"

gem "pg"
gem "bcrypt-ruby", ">= 3.0.0"
gem "cancan"

gem "coffee-rails"
gem "jquery-rails"
gem "turbolinks"
gem "uglifier"

group :production do
  gem "rails_12factor" # Heroku
  gem "unicorn", require: false
  gem "dalli"
  gem "memcachier"
end

group :development do
  gem "foreman", require: false
end

group :test do
  gem "factory_girl_rails"
end

group :development, :test do
  gem "spring"
  gem "byebug"
end
