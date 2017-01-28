get '/profile/edit' do
  erb :profile, locals: session
end

post '/profile/edit' do
  password = params['password']
  session[:user].update(password: password) if !password.empty?

  params.delete('password')
  session[:user].update(params)

  erb :profile, locals: session
end

get '/users' do
  @users = User.all

  erb :users
end

get '/user/login' do
  erb :login
end

post '/user/login' do
  user = User.find_by(e_mail: params[:e_mail]).try(:authenticate, params[:password])

  if user
    session[:user] = user

    redirect to '/'
  else
    flash.now[:error] = 'Invalid e-mail or password.'

    erb :login
  end
end

get '/logout' do
  session.clear

  redirect to '/'
end

get '/user/register' do
  erb :register
end

post '/user/register' do
  session[:user] = User.create(params)

  redirect to '/'
end
