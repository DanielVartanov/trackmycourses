require 'bundler/capistrano'
require 'rvm/capistrano'
#require "capistrano-resque"

load 'config/recipes/base'
load 'config/recipes/nginx'
load 'config/recipes/unicorn'
load 'config/recipes/check'

set :scm, :git
set :repository,  "git@github.com:railsrumble/r12-team-115.git"
set :branch, 'master'

server "coursetools.r12.railsrumble.com", :web, :app, :db, primary: true

set :user, 'deploy'
set :application, 'track-my-courses'

set :nginx_domains, "coursetools.r12.railsrumble.com"

set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :rvm_ruby_string, "1.9.3@#{application.upcase}"

# set :workers, { "email_sender" => 1 }

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :deploy do
  desc "Remove .rvmrc after fetching from repo"
  task :remove_rvmrc, roles: :app do
    run "[ -f #{current_path}/.rvmrc ] && rm #{current_path}/.rvmrc; true"
  end
end

after 'deploy:update_code', 'deploy:remove_rvmrc'
# after "deploy:restart", "resque:restart"

after 'deploy', 'deploy:cleanup'
after "deploy", "unicorn:stop_old"

require "capistrano-unicorn"

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end