set :application, "goforajob"
set :repository,  "svn://88.191.41.25/repository/projects/goforajob/trunk"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "88.191.41.25"
role :web, "88.191.41.25"
role :db,  "88.191.41.25", :primary => true

set :deploy_to, "/var/www/goforajob/"

ssh_options[:username] = 'bcaccinolo'
# set :svn_user, "benoit"

task :create_avatar_dir, :roles => :web do
  run "mkdir #{shared_path}/avatars"
end

namespace :deploy do
  desc <<-DESC
    My perso deploy for GoForAJob
  DESC
  task :default do
    update
    create_database_yml
    migrate
    restart_web
    cleanup
  end
  
  task :restart_web, :roles => :web do
    restart_mongrel
    restart_web_server    
  end
  
  task :restart_mongrel, :roles => :web do
    stop_mongrel
    start_mongrel
  end

  task :stop_mongrel, :roles => :web do
    sudo "mongrel_rails stop -c #{current_path}"
  end
  
  task :start_mongrel, :roles => :web do
    sudo "mongrel_rails start -d -e production -p 3001 -c #{current_path}"
  end

  task :restart_web_server, :roles => :web do
    sudo "/etc/init.d/apache2 stop"
    sudo "/etc/init.d/apache2 start"    
  end
  
  task :create_database_yml, :roles => :web do 
    run "mv #{current_path}/config/database.example #{current_path}/config/database.yml"
  end
  
end

