require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'sinatra/flash'

require 'carrierwave'
require "carrierwave/orm/activerecord"
require 'carrierwave/processing/mini_magick'

require 'i18n'
require 'i18n/backend/fallbacks'

Dir["#{__dir__}/models/*.rb"].each { |file| require_relative file }
Dir["#{__dir__}/routes/*.rb"].each { |file| require_relative file }

set :environment, :development
enable :sessions

configure do
  I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
  I18n.load_path = Dir[File.join(settings.root, 'config', 'locales', '*.yml')]
  I18n.backend.load_translations
  I18n.config.available_locales = [:en, :bg]
end

helpers do
  def admins_only
    halt 401, 'Not authorized' unless session[:admin]
  end
end

get '/' do
  erb :index, locals: session
end
