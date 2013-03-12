default_run_options[:pty] = true

load 'deploy/assets'
require 'bundler/capistrano'
require 'rvm/capistrano'
require 'thinking_sphinx/deploy/capistrano'
require "delayed/recipes"

set :application,             'chicago_ideas'
set :rails_env,               'production'
set :user,                    'ciw_deploy'       # 'deployer' is a far too common name
set :domain,                  'chicagoideas.com'
set :rvm_ruby_string,         '1.9.3-p385'
set :use_sudo,                false
set :scm,                     :git
set :repository,              'git@github.com:frangucc/chicago_ideas.git'
set :branch,                  'staging'

set :deploy_via,              :remote_cache
set :deploy_to,               "/home/#{user}/#{application}"
set :repository_cache,        'cached_copy'

set :unicorn_config,          "#{current_path}/config/unicorn.rb"
set :unicorn_pid,             "#{current_path}/tmp/pids/unicorn.pid"
set :unicorn_binary,          "bash -c 'source /etc/profile.d/rvm.sh && bundle exec unicorn_rails -c #{unicorn_config} -E #{rails_env} -D'"
# set :unicorn_binary,          "unicorn_rails -c #{unicorn_config} -E #{rails_env} -D"

server domain, :app, :web, :db, :primary => true

namespace :deploy do
  desc "Copies shared config files"
  task :copy_shared_files do
    run "cp #{deploy_to}/shared/config/*.yml #{current_release}/config/"
  end

  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    run "kill `cat #{unicorn_pid}`"
  end

  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "kill -s QUIT `cat #{unicorn_pid}`"
  end

  task :reload, :roles => :app, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{unicorn_pid}`"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end

  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      # If this is our first deploy - don't check for the previous version
      if remote_file_exists?(current_path)
        from = source.next_revision(current_revision)
        if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
          run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
        else
          logger.info "Skipping asset pre-compilation because there were no asset changes"
        end
      else
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      end
    end
  end
end

def remote_file_exists?(full_path)
  'true' ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end

after 'deploy:update_code', 'deploy:copy_shared_files'

after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start", "thinking_sphinx:rebuild"