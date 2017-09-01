require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'sinatra/flash'

require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'carrierwave/processing/mini_magick'

require 'i18n'
require 'i18n/backend/fallbacks'

require 'will_paginate'
require 'will_paginate/active_record'

helpers do
  def authenticated?
    session.include? :id
  end

  def admin?
    session[:admin]
  end

  def student?
    authenticated? && !admin?
  end
end

register do
  def allow(*roles)
    condition do
      if roles.include? :user
        redirect '/user/login' unless authenticated?
      elsif roles.include? :admin
        redirect back unless admin?
      end
    end
  end
end

Dir["#{__dir__}/models/*.rb"].each { |file| require_relative file }
Dir["#{__dir__}/routes/*.rb"].each { |file| require_relative file }

set :environment, :development
enable :sessions
set :session_secret, '*&(^B234'

configure do
  I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
  I18n.load_path = Dir[File.join(settings.root, 'config', 'locales', '*.yml')]
  I18n.backend.load_translations
  I18n.config.available_locales = %i[en bg]
end

get '/' do
  erb :index
end
