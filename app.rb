require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

require 'carrierwave'
require "carrierwave/orm/activerecord"
require 'carrierwave/processing/mini_magick'

Dir["#{__dir__}/models/*.rb"].each { |file| require_relative file }
Dir["#{__dir__}/routes/*.rb"].each { |file| require_relative file }

set :environment, :development
enable :sessions

helpers do
  def admins_only
    halt 401, 'Not authorized'  unless session[:admin]
  end
end

get '/' do
  erb :index, locals: session
end
