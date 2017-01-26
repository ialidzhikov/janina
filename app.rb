require 'sinatra'
require 'sinatra/activerecord'

Dir["#{__dir__}/models/*.rb"].each { |file| require_relative file }
Dir["#{__dir__}/routes/*.rb"].each { |file| require_relative file }

set :environment, :development
enable :sessions

#set :root, __dir__

get '/' do
  erb :index
end
