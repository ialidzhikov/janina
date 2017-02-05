require 'json'

namespace :db do
  namespace :users do
    task :import_admins do
      content = File.read('config/users/admins.json')
      admins = JSON.parse(content)
      admins.each do |admin|
        User.create(admin)
      end
    end
  end
end
