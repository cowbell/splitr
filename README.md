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
