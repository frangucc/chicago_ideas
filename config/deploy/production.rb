set :rails_env,               'production'
set :domain,                  'chicagoideas.com'
set :branch,                  'master'

server domain, :app, :web, :db, :primary => true
