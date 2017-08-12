require 'github/markup'

get '/tasks/:id' do |id|
  @task = Task.find(id)
  @admin = session[:admin]

  erb :task
end

get '/tasks' do
  @tasks = Task.all

  erb :tasks
end

post '/tasks' do
  admins_only

  description = File.read(params[:description][:tempfile], encoding: 'utf-8')
  params[:description] = description

  Task.create(params)

  redirect to '/tasks'
end

get '/task/add' do
  admins_only

  erb :task_add
end

get '/tasks/:id/edit' do |id|
  admins_only

  @task = Task.find(id)

  erb :task_edit
end

put '/tasks/:id' do |id|
  admins_only

  task = Task.find(id)

  transient = params.select do |key, _|
    [:name, :description, :deadline].include? key.to_sym
  end
  task.update(transient)

  redirect to :tasks
end
