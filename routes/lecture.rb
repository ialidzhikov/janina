require_relative 'validators/lecture_validator'

get '/lectures' do
  @lectures = Lecture.all

  erb :'lectures/index'
end

post '/lectures', allow: :admin do
  return erb :'lectures/add' unless LectureValidator.new.valid?(params, flash)

  Lecture.create(params)

  redirect to '/lectures'
end

delete '/lectures/:id', allow: :admin do |id|
  Lecture.destroy(id)

  redirect to '/lectures'
end

get '/lecture/add', allow: :admin do
  erb :'lectures/add'
end

get '/lectures/:id/edit', allow: :admin do |id|
  @lecture = Lecture.find(id)

  erb :'lectures/edit'
end

put '/lectures/:id', allow: :admin do |id|
  @lecture = Lecture.find(id)

  transient = params.select do |key, _|
    %i[name content date].include? key.to_sym
  end

  transient['content'] = @lecture.content unless transient.include? 'content'
  unless LectureValidator.new.valid?(transient, flash)
    return erb :'lectures/edit'
  end

  @lecture.update(transient)

  redirect to :lectures
end
