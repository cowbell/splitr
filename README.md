# splitr

## Development

Copy and customize configuration files

```
cp config/database.{yml.example,yml}
cp .env{.example,}
bundle install
bundle exec foreman run rake db:setup
bundle exec foreman start
```

If you're running the app in a production environment, it's also
necessary to generate a new `SECRET_KEY_BASE` by runing `rake secret`
and pasting it into `.env` file.
