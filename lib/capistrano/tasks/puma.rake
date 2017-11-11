namespace :puma do
  %w[start stop restart status].each do |cmd|
    desc "#{cmd.capitalize} the application server"
    task cmd do
      on roles(:all) do
        execute "/sbin/#{cmd}", 'puma', 'app=/var/www/spaceholder.cc/current'
      end
    end
  end
end
