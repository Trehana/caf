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
  namespace :assets do
    task :bunde_exec do
      if fetch(:rails_env) == 'development'
        run_locally do
          execute :bundle, 'install'
        end
      end
    end
  end

  namespace :assets do
    task :precompile do
      run_locally do
        execute("RAILS_ENV=#{fetch(:rails_env)} bundle exec rake assets:clean && RAILS_ENV=#{fetch(:rails_env)} bundle exec rake assets:precompile")
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      run_locally do
        execute :bundle, 'exec unicorn restart'
      end
    end
  end
end
