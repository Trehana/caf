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
    task :precompile do
      run_locally do
        execute("RAILS_ENV=#{fetch(:rails_env)} bundle exec rake assets:clean && RAILS_ENV=#{fetch(:rails_env)} bundle exec rake assets:precompile")
      end
    end
  end

  desc 'Restart application'
  namespace :app_server do
    task :restart do
      on roles(:app), in: :sequence, wait: 5 do
        run_locally do
          execute :bundle, 'exec unicorn restart'
        end
      end
    end
  end

  after 'deploy', 'bundler:install'
  after 'bundler:install', 'deploy:assets:precompile'
  after 'deploy:assets:precompile', 'deploy:app_server:restart'
end
