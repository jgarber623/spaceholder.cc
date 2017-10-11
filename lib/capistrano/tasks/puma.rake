namespace :puma do
  %w[start stop restart].each do |cmd|
    desc "#{cmd.capitalize} the application server"
    task cmd do
      on roles(:all) do
        execute :sudo, '/usr/sbin/service', 'spaceholder.cc-puma', cmd
      end
    end
  end
end
