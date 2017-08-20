get '/leaderboard' do
  @users = User.all

  erb :'leaderboard/index'
end
