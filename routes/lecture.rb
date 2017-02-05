get '/lectures' do
  @lectures = Lecture.all
  @admin = session[:admin]

  erb :lectures
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

  erb :lecture_add
end

get '/lecture/:id/edit' do |id|
  admins_only

  @lecture = Lecture.find(id)

  erb :lecture_edit
end

put '/lecture/:id' do |id|
  admins_only

  lecture = Lecture.find(id)

  transient = params.select do |key, _|
    [:name, :content, :date].include? key.to_sym
  end
  lecture.update(transient)

  redirect to :lectures
end
