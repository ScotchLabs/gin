m = "rorqual.reisub.net"

set :application, "sns-dev"
set :deploy_to, "/www/#{application}"
set :repository,  "svn+ssh://rorqual.reisub.net/svn/sites/sns-org"
set :checkout, "export"

set :scm, :subversion
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, m                    # Your HTTP server, Apache/etc
role :app, m                    # This may be the same as your `Web` server
role :db,  m, :primary => true	# This is where Rails migrations will run

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
