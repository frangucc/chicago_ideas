set :rails_env,               'staging'
set :domain,                  '54.225.238.30'
set :branch,                  'staging'

server domain, :app, :web, :db, :primary => true
