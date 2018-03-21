# rails-timez
A small app to check timezones of Times and Dates on Rails

> [TTaaS (Time Travel as a Service)](https://twitter.com/heroku/status/719712029343395841)

## Usage
### Preparation
Specify Ruby version (optional)
```
$ rbenv local 2.5.0
$ rbenv exec gem install bundler
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
System timezone: UTC
Rails' timezone: America/Los_Angeles
1993-02-24 03:00:00 +00:00 <- Time.now	(Time)
1993-02-22 00:00:00 +00:00 <- Date.yesterday	(Date)
1993-02-24 00:00:00 +00:00 <- Date.today	(Date)
1993-02-24 00:00:00 +00:00 <- Date.tomorrow	(Date)
1993-02-23 19:00:00 -08:00 <- DateTime.current	(DateTime)
1993-02-24 03:00:00 +00:00 <- DateTime.now	(DateTime)
1993-02-23 19:00:00 -08:00 <- Time.zone.now	(ActiveSupport::TimeWithZone)
1993-02-23 19:00:00 -08:00 <- Time.now.in_time_zone	(ActiveSupport::TimeWithZone)
```

### Time Travel as a Service
```
System timezone: UTC
Rails' timezone: America/Los_Angeles
> Date.today == Date.tomorrow
=> true
> Date.today
=> 2016-04-12
> Date.yesterday
=> 2016-04-10
WAT
2016-04-12 01:59:00 +00:00 <- Time.now	(Time)
2016-04-11 18:59:00 -07:00 <- Time.zone.now	(ActiveSupport::TimeWithZone)
2016-04-10 00:00:00 +00:00 <- Date.yesterday	(Date)
2016-04-12 00:00:00 +00:00 <- Date.today	(Date)
2016-04-12 00:00:00 +00:00 <- Date.tomorrow	(Date)
2016-04-10 00:00:00 +00:00 <- Time.zone.yesterday	(Date)
2016-04-11 00:00:00 +00:00 <- Time.zone.today	(Date)
2016-04-12 00:00:00 +00:00 <- Time.zone.tomorrow	(Date)
```

It seems that `Date.today` calls the method from [a standard library](http://ruby-doc.org/stdlib-2.3.1/libdoc/date/rdoc/Date.html#method-c-today) that honors the system timezone while `Date.yesterday` and `Date.tomorrow` are [from Rails](http://api.rubyonrails.org/v4.2/classes/Date.html#method-c-tomorrow) (ActiveSupport) which honor Rails' timezone.

### Multi threaded travel around the world
Change `ENV['TZ']` and see what happens:

```
$ bundle exec rake timezones:sys:travel
Traveling time ...!!!!
03:00 UTC became 22:00 in Japan (shuold be 12:00)
03:00 UTC became 03:00 in HST (shuold be 17:00)
03:00 UTC became 12:00 in EST (shuold be 22:00)
03:00 UTC became 17:00 in Japan (shuold be 12:00)
```

- 2 - 6 inconsistencies on ruby 2.3.1 on Ubuntu 15.10 on a 2-core CPU
- 0 - 1 inconsistencies on ruby 2.3.1 on OSX 10.11.4 on 4-core CPU

Use Rails' `TimeWithZone#in_time_zone(tz)`:

```
$ bundle exec rake timezones:rails:travel
Traveling time ...
completed time travel
```

Seems to be thread safe. But how?

```
$ bundle exec rake tzinfo:patch
  :
TZInfo::TimezoneOffset.new
  @abbreviation = KST
  @std_offset = 0
  @utc_offset = 32400
  @utc_total_offset = 32400
TZInfo::TimezoneOffset#to_local(2015-08-15 00:00:00 UTC) is called
2015-08-15 08:30:00 +0830
```

Uses tzinfo gem.

## References
- [RubyとRailsにおけるTime, Date, DateTime, TimeWithZoneの違い - Qiita](http://qiita.com/jnchito/items/cae89ee43c30f5d6fa2c)

## License
MIT. See [LICENSE](LICENSE)
