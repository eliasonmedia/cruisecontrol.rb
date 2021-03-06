#
# Basic flipstone utility tasks
#
desc <<-DESC
  Push the deploy key and create the GIT_SSH script to use it
DESC
task :install_deploy_keys, :roles => :app do
  deploy_key_path = "#{deploy_to}/id_deploy"
  run "rm -f #{deploy_key_path}"
  top.upload("config/deploy/deploy_key", deploy_key_path, :via => :scp)
  run "chmod 400 #{deploy_key_path}"
  
  wrapper_path = "#{deploy_to}/git_ssh.sh"
  gitssh = "/usr/bin/env ssh -o StrictHostKeyChecking=no -i #{deploy_key_path} $1 $2\n"
  put gitssh, wrapper_path
  run "chmod 755 #{wrapper_path}"
  run "export GIT_SSH=#{wrapper_path}"
end

desc "pushes the fs-buildserver account-level key to ubuntu user"
task :install_flipstone_key, :roles => :app do
  fs_key_path = "/home/ubuntu/.ssh/id_rsa"
  top.upload("#{ENV['HOME']}/.ssh/fs-buildserver", fs_key_path, :via => :scp)
  run "chmod 400 #{fs_key_path}"
end

desc <<-DESC
  Prepare a freshly launched machine for doing a full deployment.  If the environment runs its own
  DB server, the appropriate database will need to be created manually as well.
DESC
task :prepare_new_box do
  deploy.setup
  install_flipstone_key
  deploy.update
  deploy.unicorn_config
  nginx.config
  nginx.site_enable
  nginx.reload
end

task :sanity_check do
  SAFEWORD = "arglebargle"
  
  puts " **\n **" 
  puts (" ** PRODUCTION TARGET SANITY CHECK ** ") 
  puts " **\n **" 

  set(:safeword, Capistrano::CLI.ui.ask(" ** Please confirm with safeword '#{SAFEWORD}' or [Enter] to abort:"))
  unless safeword == SAFEWORD
    puts (" ** Safeword check failed.  Aborting.") 
    exit! -1
  end
end

