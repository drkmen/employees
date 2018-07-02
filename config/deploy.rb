# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, 'employees'
set :repo_url, 'git@github.com:drkmen/employees.git'

set :use_sudo, false

set :rvm_type, :system                     # Defaults to: :auto
set :rvm_ruby_version, '2.4.1'            # Defaults to: 'default'
# set :rvm_custom_path, '~/.myveryownrvm'  # only needed if not detected

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/secrets.yml'#, '.env.production'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/uploads', '.bundle'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

task :execute, :command do |_task, args|
  on roles :app do
    within current_path do
      # gavno kakoeto
      # https://stackoverflow.com/questions/19452983/capistrano-3-execute-within-a-directory

      # cap production "execute[update:role['developer']]"
      execute :bundle, "exec rake #{args[:command]} RAILS_ENV=production"
    end
  end
end

namespace :deploy do

  task :create_symlink do
    on roles :app do
      within current_path do
        p '****************** CREATE SYMLINK ******************'
        execute 'ln -s /home/production/www/employees/shared/config/.env.production /home/production/www/employees/current'
      end
    end
  end

  task :restart do
    on roles :app do
      within current_path do
        p '****************** REBOOTING SERVER ******************'
        execute "kill -SIGKILL `cat /home/production/www/employees/shared/tmp/pids/server.pid` && rm /home/production/www/employees/shared/tmp/pids/server.pid"
        execute :bundle, "exec rails s -e production -d -p 3005"
      end
    end
  end

  task :seed do
    on roles :app do
      within current_path do
        execute :rake, "db:seed"
      end
    end
  end

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     within release_path do
  #       execute :rake, 'assets:clean'
  #     end
  #   end
  # end

end

after 'deploy:finished', 'deploy:create_symlink'
after 'deploy:finished', 'deploy:restart'