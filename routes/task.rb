require 'github/markup'
require_relative 'validators/task_validator'

get '/tasks/:id' do |id|
  @task = Task.find(id)
  @admin = session[:admin]

  erb :'tasks/show'
end

get '/tasks' do
  @tasks = Task.all
  @admin = session[:admin]

  erb :'tasks/index'
end

post '/tasks' do
  admins_only

  return erb :'tasks/add' unless TaskValidator.new.valid?(params, flash)

  description = File.read(params[:description][:tempfile], encoding: 'utf-8')
  params[:description] = description

  Task.create(params)

  redirect to '/tasks'
end

delete '/tasks/:id' do |id|
  admins_only

  Task.destroy(id)

  redirect to '/tasks'
end

get '/task/add' do
  admins_only

  erb :'tasks/add'
end

get '/tasks/:id/edit' do |id|
  admins_only

  @task = Task.find(id)

  erb :'tasks/edit'
end

put '/tasks/:id' do |id|
  admins_only

  @task = Task.find(id)
  transient = params.select do |key, _|
    %i[name description deadline max_points].include? key.to_sym
  end

  if transient.include? 'description'
    transient['description'] =
      File.read(params[:description][:tempfile], encoding: 'utf-8')
  else
    transient['description'] = @task.description
  end
  return erb :'tasks/edit' unless TaskValidator.new.valid?(transient, flash)

  @task.update(transient)

  redirect to '/tasks'
end
