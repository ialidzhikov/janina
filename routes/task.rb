require 'github/markup'
require_relative 'validators/task_validator'

get '/tasks/:id' do |id|
  @task = Task.find(id)

  erb :'tasks/show'
end

get '/tasks' do
  @tasks = Task.all

  erb :'tasks/index'
end

post '/tasks', allow: :admin do
  return erb :'tasks/add' unless TaskValidator.new.valid?(params, flash)

  description = File.read(params[:description][:tempfile], encoding: 'utf-8')
  params[:description] = description

  Task.create(params)

  redirect to '/tasks'
end

delete '/tasks/:id', allow: :admin do |id|
  Task.destroy(id)

  redirect to '/tasks'
end

get '/task/add', allow: :admin do
  erb :'tasks/add'
end

get '/tasks/:id/edit', allow: :admin do |id|
  @task = Task.find(id)

  erb :'tasks/edit'
end

put '/tasks/:id', allow: :admin do |id|
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
