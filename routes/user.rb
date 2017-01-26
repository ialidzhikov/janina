get '/user/login' do
  erb :login
end

post '/user/login' do
  e_mail = params[:e_mail]
  password = params[:password]

  p e_mail
  p password

  'Hello world'
end

get '/user/register' do
  erb :register
end

post '/user/register' do
  @user = User.create(params)
  session[:user] = @user

  erb :index
end
