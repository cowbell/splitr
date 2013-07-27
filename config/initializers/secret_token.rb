if Rails.env.test? or Rails.env.development?
  Splitr::Application.config.secret_key_base = "03afb1f6415febf6c5bc72294568ec74968ccf81943614ca56a89505e19d9be3a99054564d628b7a86b2f3495ea79576f1909d96712178f81a962ca8eb0dc575"
else
  raise "You must set a secret key base in ENV['SECRET_KEY_BASE'] or in config/initializers/secret_token.rb" if ENV["SECRET_KEY_BASE"].blank?
  Splitr::Application.config.secret_key_base = ENV["SECRET_KEY_BASE"]
end
