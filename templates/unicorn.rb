# from railscasts.com episode 335 Deploying to VPS
root = "/home/deployer/apps/app_name/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.app_name.sock"
worker_processes 2
timeout 30