role :app,        %w(178.172.173.210)
role :web,        %w(178.172.173.210)
role :db,         %w(178.172.173.210), primary: true
set :application, 'ruby-app'

server '178.172.173.210', user: fetch(:application), roles: %w(web app db), primary: true

set :full_app_name, 'ruby-app'
set :rails_env,   'production'

namespace :deploy do
  desc 'Restart application'
  task :stop do
    on roles(:app), in: :sequence, wait: 10 do
      # command that is used to stop Unicorn goes here
      execute 'sudo systemctl stop ruby-app.service'
    end
  end

  task :start do
    on roles(:app), in: :sequence, wait: 10 do
      # command that is used to start Unicorn goes here
      execute 'sudo systemctl start ruby-app.service'
    end
  end

  after :publishing, :stop
  after :stop, :start
end