get '/leaderboard' do
  @records = LeaderboardRecord.all

  erb :'leaderboard/index'
end
