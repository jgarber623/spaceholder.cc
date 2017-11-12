namespace :puma do
  %w[start stop restart].each do |cmd|
    desc "#{cmd.capitalize} the application server"
    task cmd do
      on roles(:all) do
        execute :sudo, "/sbin/#{cmd}", 'puma', 'app=/var/www/spaceholder.cc/current'
      end
    end
  end
end
