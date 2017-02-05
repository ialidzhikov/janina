require 'sinatra/activerecord/rake'
require './app'

Dir.glob('lib/tasks/*.rake').each { |task| load task }

namespace :db do
  task :load_config do
    require './app'
  end
end
