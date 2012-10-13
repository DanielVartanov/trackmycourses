set_default(:unicorn_user) { user }
set_default(:unicorn_pid) { "#{current_path}/tmp/pids/unicorn.pid" }
set_default(:unicorn_config) { "#{shared_path}/config/unicorn.rb" }
set_default(:unicorn_log) { "#{shared_path}/log/unicorn.log" }
set_default(:unicorn_workers, 2)

namespace :unicorn do
  desc 'Setup Unicorn initializer and app configuration'
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template 'unicorn.rb.erb', unicorn_config
    template 'unicorn_init.erb', '/tmp/unicorn_init'
    run "chmod +x /tmp/unicorn_init"
    run "#{sudo} mv /tmp/unicorn_init /etc/init.d/unicorn_#{application}"
    run "#{sudo} update-rc.d -f unicorn_#{application} defaults"
  end
  after 'deploy:setup', 'unicorn:setup'

  desc "Create symlink of unicorn configuration"
  task :create_symlink, roles: :app do
    run "mkdir -p #{current_path}/config/unicorn"
    run "rm #{current_path}/config/unicorn/production.rb; true"
    run "ln -s #{unicorn_config} #{current_path}/config/unicorn/production.rb; true"
  end
  after 'deploy:create_symlink', 'unicorn:create_symlink'

  desc "Stop old master"
  task :stop_old, roles: :app do
    old_pid = "#{unicorn_pid}.oldbin"
    logger.important("Trying to stop...", "Unicorn")
    run "#{try_sudo} kill -s QUIT `cat #{old_pid}`; true"
  end

end
