web: bundle exec passenger start
worker: bundle exec sidekiq -c 1 -t 25 -q default -q mailers
