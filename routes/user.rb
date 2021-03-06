require_relative 'validators/user_validator'

get '/profile/edit', allow: :user do
  @user = User.find(session[:id])

  erb :'users/profile'
end

post '/profile/edit', allow: :user do
  @user = User.find(session[:id])

  password = params['password']
  unless password.empty?
    @user.update(password: password)
    params.delete('password')
  end

  if params['remove_photo']
    @user.remove_photo!
    @user.save
  end

  @user.update(params)

  erb :'users/profile'
end

get '/users' do
  @users = User.students.paginate(page: params[:page], per_page: 10)

  erb :'users/index'
end

get '/user/login' do
  erb :'/users/login'
end

post '/user/login' do
  user = User.find_by(e_mail: params[:e_mail])
             .try(:authenticate, params[:password])

  unless user
    flash.now[:error] = 'Invalid e-mail or password.'

    return erb :'/users/login'
  end

  store(user)

  redirect to '/'
end

get '/logout' do
  session.clear

  redirect to '/'
end

get '/user/register' do
  erb :'users/register'
end

post '/user/register' do
  return erb :'/users/register' unless UserValidator.new.valid?(params, flash)

  transient = params.select do |key, _|
    %i[full_name faculty_number e_mail password].include? key.to_sym
  end

  user = User.create(transient)
  store(user)

  redirect to '/'
end

private

def store(user)
  session[:id] = user.id
  session[:e_mail] = user.e_mail
  session[:admin] = user.admin?
end
