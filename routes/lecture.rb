get '/lectures' do
  @lectures = Lecture.all
  @admin = session[:admin]

  erb :'lectures/index'
end

post '/lectures' do
  admins_only

  Lecture.create(params)

  redirect to '/lectures'
end

delete '/lectures/:id' do |id|
  admins_only

  Lecture.destroy(id)

  redirect to '/lectures'
end

get '/lecture/add' do
  admins_only

  erb :'lectures/add'
end

get '/lectures/:id/edit' do |id|
  admins_only

  @lecture = Lecture.find(id)

  erb :'lectures/edit'
end

put '/lectures/:id' do |id|
  admins_only

  lecture = Lecture.find(id)

  transient = params.select do |key, _|
    %i[name content date].include? key.to_sym
  end
  lecture.update(transient)

  redirect to :lectures
end