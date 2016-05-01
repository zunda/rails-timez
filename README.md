# rails-timez
A small app to check timezones of Times and Dates on Rails

> [TTaaS (Time Travel as a Service)](https://twitter.com/heroku/status/719712029343395841)

## Usage
### Preparation
Specify Ruby version (optional)
```
$ rbenv local 2.3.0
$ gem install bundler
$ rbenv rehash
```

Prepare gems and the database (even not used)
```
$ bundle install --path=vendor/bundle
$ bundle exec rake db:migrate
```

### Show time
```
$ bundle exec rake timestamp:show
System timezone: JST
Rails' timezone: UTC
1993-02-24 12:00:00 +09:00 <- Time.now	(Time)
1993-02-24 00:00:00 +00:00 <- Date.today	(Date)
1993-02-24 03:00:00 +00:00 <- DateTime.current	(DateTime)
1993-02-24 12:00:00 +09:00 <- DateTime.now	(DateTime)
1993-02-24 03:00:00 +00:00 <- Time.zone.now	(ActiveSupport::TimeWithZone)
1993-02-24 03:00:00 +00:00 <- Time.now.in_time_zone	(ActiveSupport::TimeWithZone)
```

## References
- [RubyとRailsにおけるTime, Date, DateTime, TimeWithZoneの違い - Qiita](http://qiita.com/jnchito/items/cae89ee43c30f5d6fa2c)

## License
MIT. See [LICENSE](LICENSE)
