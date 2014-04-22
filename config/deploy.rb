require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
# require 'mina/rvm'    # for rvm support. (http://rvm.io)
require 'mina/puma'

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, 'cwaniak.eu'
set :deploy_to, '/var/www/kosynierka.info'
set :repository, 'git://github.com/kosynierzy/kosynierka.info.git'
set :branch, 'master'
set :bundle_bin, './bin/bundle'
set :bundle_options, lambda { %{--without development:test --path "#{bundle_path}" --deployment} }
settings.rake_assets_precompile = lambda { "#{rake} assets:precompile" }

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'log', 'tmp', '.rbenv-vars', 'config/puma.rb']

# Optional settings:
set :user, 'deploy'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.

# Puma settings
puma_socket "unix:///#{deploy_to}/#{shared_path}/tmp/sockets/puma.sock"
puma_pid "#{deploy_to}/#{shared_path}/tmp/pids/puma.pid"
puma_state "#{deploy_to}/#{shared_path}/tmp/states/puma.state"
pumactl_socket "unix:///#{deploy_to}/#{shared_path}/tmp/sockets/pumactl.sock"

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .rbenv-version to your repository.
  invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use[ruby-1.9.3-p125@default]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue  %[echo "-----> Be sure to edit '#{shared_path}/config/database.yml'."]

  queue! %[touch "#{deploy_to}/#{shared_path}/.rbenv-vars"]
  queue  %[echo "-----> Be sure to edit '#{shared_path}/.rbenv-vars'."]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/puma.rb"]
  queue  %[echo "-----> Be sure to edit '#{shared_path}/config/puma.rb'."]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/pids"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/sockets"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/states"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp"]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :launch do
      queue "touch #{deploy_to}/#{shared_path}/tmp/restart.txt"
      invoke :'puma:phased_restart'
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

