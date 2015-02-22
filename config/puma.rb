preload_app!

rackup DefaultRackup
port 5000
environment 'production'
daemonize
pidfile 'tmp/puma.pid'
stdout_redirect 'log/puma.stdout', 'log/puma.stderr', true

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
