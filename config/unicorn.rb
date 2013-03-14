# 4 workers is enough for our app
worker_processes 4

# App location
@app = "/home/ubuntu/rails_apps/chicago_ideas/current"

# Listen on fs socket for better performance
listen "#{@app}/tmp/sockets/unicorn.sock", :backlog => 64

# Nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

# App PID
pid "#{@app}/tmp/pids/unicorn.pid"

# By default, the Unicorn logger will write to stderr.
# Additionally, some applications/frameworks log to stderr or stdout,
# so prevent them from going to /dev/null when daemonized here:
stderr_path "#{@app}/log/unicorn.stderr.log"
stdout_path "#{@app}/log/unicorn.stdout.log"

# To save some memory and improve performance
preload_app true

GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

# Force the bundler gemfile environment variable to
# reference the Сapistrano "current" symlink
before_exec do |_|
  ENV["BUNDLE_GEMFILE"] = File.join(@app, 'Gemfile')
end

# before_fork do |server, worker|
#   # the following is highly recomended for Rails + "preload_app true"
#   # as there's no need for the master process to hold a connection
#   defined?(ActiveRecord::Base) and
#     ActiveRecord::Base.connection.disconnect!
# end
#
# after_fork do |server, worker|
#   # the following is *required* for Rails + "preload_app true",
#   defined?(ActiveRecord::Base) and
#     ActiveRecord::Base.establish_connection
# end


# Zero downtime deploy as per http://goo.gl/5RHvC

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  # Before forking, kill the master process that belongs to the .oldbin PID.
  # This enables 0 downtime deploys.
  old_pid = "#{@app}/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  # the following is *required* for Rails + "preload_app true",
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end

  # if preload_app is true, then you may also want to check and
  # restart any other shared sockets/descriptors such as Memcached,
  # and Redis.  TokyoCabinet file handles are safe to reuse
  # between any number of forked children (assuming your kernel
  # correctly implements pread()/pwrite() system calls)
end