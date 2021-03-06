load 'deploy' if respond_to?(:namespace) # cap2 differentiator

load 'config/secure_cap.rb'


# require 'deprec/recipes'
# require 'mongrel_cluster/recipes'

# =============================================================================
# ROLES
# =============================================================================
# You can define any number of roles, each of which contains any number of
# machines. Roles might include such things as :web, or :app, or :db, defining
# what the purpose of each machine is. You can also specify options that can
# be used to single out a specific subset of boxes in a particular role, like
# :primary => true.

set :domain, "smartbomb.com.au"
role :web, domain
role :app, domain
role :db,  domain, :primary => true

# set :use_sudo, false

# =============================================================================
# REQUIRED VARIABLES
# =============================================================================
# You must always specify the application and repository for every recipe. The
# repository must be the URL of the repository you want this recipe to
# correspond to. The deploy_to path must be the path on each machine that will
# form the root of the application path.

set :application, "facebook"
set :deploy_to, lambda { "/var/www/apps/#{application}" }

# XXX we may not need this - it doesn't work on windows
# XXX set :user, ENV['USER']
# set :repository, "http://rails-oceania.googlecode.com/svn/facebook"

set :scm, 'git'
set :repository, 'git://github.com/lachie/roro-faces.git'
set :repository_cache, "git_master"
set :deploy_via, :remote_cache

set :rails_env, "production"

# Automatically symlink these directories from current/public to shared/public.
# set :app_symlinks, %w{photo, document, asset}

set :app_symlinks, %w{mugshots}

set :keep_releases, 3

# =============================================================================
# APACHE OPTIONS
# =============================================================================
# set :apache_server_name, domain
# set :apache_server_aliases, %w{alias1 alias2}
# set :apache_default_vhost, true # force use of apache_default_vhost_config
# set :apache_default_vhost_conf, "/etc/httpd/conf/default.conf"
# set :apache_conf, "/etc/httpd/conf/apps/#{application}.conf"
# set :apache_ctl, "/etc/init.d/httpd"
# set :apache_proxy_port, 8000
# set :apache_proxy_servers, 2
# set :apache_proxy_address, "127.0.0.1"
# set :apache_ssl_enabled, false
# set :apache_ssl_ip, "127.0.0.1"
# set :apache_ssl_forward_all, false
# set :apache_ssl_chainfile, false


# =============================================================================
# MONGREL OPTIONS
# =============================================================================
# set :mongrel_servers, apache_proxy_servers
# set :mongrel_port, apache_proxy_port

set :mongrel_port, 8004
set :mongrel_address, "0.0.0.0"

# set :mongrel_environment, "production"
# set :mongrel_config, "/etc/mongrel_cluster/#{application}.conf"
# set :mongrel_user, user
# set :mongrel_group, group

# =============================================================================
# MYSQL OPTIONS
# =============================================================================


# =============================================================================
# SSH OPTIONS
# =============================================================================
# ssh_options[:keys] = %w(/path/to/my/key /path/to/another/key)
# ssh_options[:port] = 25

task :beta, :roles => :app, :except => { :no_release => true } do
  set :application, "faces-beater"
end


desc "Link up database.yml."
after 'deploy:symlink' do
  # run "rm -rf #{current_path}/public/mugshots"
  # symlink_public
 run "ln -nfs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
 run "ln -nfs #{shared_path}/config/gmail.rb #{current_path}/config/gmail.rb"
 run "ln -nfs #{shared_path}/config/shared_secret.rb #{current_path}/config/shared_secret.rb"
 
 run "rm -rf #{current_path}/public/mugshots"
 run "ln -nfs #{shared_path}/public/mugshots #{current_path}/public/mugshots"
end

namespace :deploy do  
  task :stop, :roles => :app, :except => { :no_release => true } do
    run %{
      mongrel_rails cluster::stop -C #{shared_path}/mongrel_cluster.yml
    }
  end
  task :start, :roles => :app, :except => { :no_release => true } do
    run %{
      mongrel_rails cluster::start -C #{shared_path}/mongrel_cluster.yml
    }
  end
  
  task :restart, :roles => :app, :except => { :no_release => true } do
    run <<-EOR
      mongrel_rails cluster::stop -C #{shared_path}/mongrel_cluster.yml &&
      mongrel_rails cluster::start -C #{shared_path}/mongrel_cluster.yml
    EOR
  end
end

task :remove_graphs, :role => :app do
  run "cd #{current_path}/public && rm users/chatter.svg"
  run "cd #{current_path}/public && rm thankyous/beergraph.svg"
end

