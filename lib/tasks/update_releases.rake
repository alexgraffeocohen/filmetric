desc "Updates release years of all movies"
task :update_releases => :environment do
  Movie.replace_release_years
end