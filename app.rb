require 'sinatra'
require 'sinatra/activerecord'

Dir["#{__dir__}/models/*.rb"].each { |file| require_relative file }

set :environment, :development

get '/' do
  erb :index
end
