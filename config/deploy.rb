require 'bundler/capistrano'
require "rvm/capistrano"

set :application, "filmetric"
set :repository,  "git@github.com:alexwilkinson/filmetric_rails.git"

set :user, "alex"
set :deploy_to, "/home/#{user}/#{application}"
set :use_sudo, false

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

default_run_options[:pty] = true

role :web, "107.170.111.8"                          # Your HTTP server, Apache/etc
role :app, "107.170.111.8"                          # This may be the same as your `Web` server
# role :db,  "107.170.111.8", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  # task :source_rvm, roles: :app do
  #   run "source /home/alex/.rvm/scripts/rvm && rvm reload"
  # end
end

# # set :rvm_ruby_string, '2.0.0'
# before 'deploy:setup', 'rvm:install_rvm'
# before 'deploy:setup', 'rvm:install_ruby'