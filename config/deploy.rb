# config valid only for current version of Capistrano
lock '3.4.0'

set :rails_env, fetch(:stage)

set :application, 'caffa'
set :scm, :git
set :repo_url, 'git@bitbucket.org:zpixel/caffa_rails.git'
set :deploy_to, '/var/www/caffa'
set :current_path, -> { "%s/current" % [fetch(:deploy_to)] }
set :pty, false
set :use_sudo, true
set :ssh_options, forward_agent: true

set :linked_dirs, %w(log tmp vendor/bundle public/assets public/system)

namespace :deploy do
  desc 'Precompile assets'
  namespace :assets do
    task :clean_and_precompile do
      if fetch(:rails_env) != 'development'
        'deploy:cleanup_assets'
        'deploy:compile_assets'
      end
    end
  end

  desc 'Start the application'
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{stage} bundle exec puma -b 'unix://#{shared_path}/sockets/puma.sock' -S #{shared_path}/sockets/puma.state --control 'unix://#{shared_path}/sockets/pumactl.sock' >> #{shared_path}/log/puma-#{stage}.log 2>&1 &", :pty => false
  end

  desc "Stop the application"
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{stage} bundle exec pumactl -S #{shared_path}/sockets/puma.state stop"
  end

  desc "Restart the application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{stage} bundle exec pumactl -S #{shared_path}/sockets/puma.state restart"
  end

  desc "Status of the application"
  task :status, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{stage} bundle exec pumactl -S #{shared_path}/sockets/puma.state stats"
  end

  after 'deploy', 'bundler:install'
  after 'bundler:install', 'deploy:migrate'
  after 'deploy:migrate', 'deploy:assets:clean_and_precompile'
  after 'deploy:published', 'deploy:restart'
end
