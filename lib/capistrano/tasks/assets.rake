namespace :assets do
  desc 'Precompile assets within the release path'
  task :precompile do
    on roles(:all) do
      within fetch(:release_path) do
        with rack_env: fetch(:stage) do
          execute :rake, 'assets:clean'
          execute :rake, 'assets:precompile'
        end
      end
    end
  end
end
