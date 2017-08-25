require 'coderay'

get '/tasks/:task_id/solutions/:id' do |_, id|
  @user = User.find(session[:id])
  @solution = Solution.find(id)
  code = @solution.last_submission.code

  @lines = CodeRay.scan(code, :ruby).html(wrap: nil).split("\n")

  erb :'solutions/show', locals: session
end

get '/tasks/:id/solutions' do |id|
  @solutions = Solution.where(task_id: id)

  erb :'solutions/index'
end

post '/tasks/:id/solutions' do |id|
  @task = Task.find(id)
  @code = params[:code]

  solution = Solution.find_or_create_by(user_id: session[:id], task_id: id)
  Submission.create(solution_id: solution.id, code: @code)

  erb :'my_solution/show', locals: session
end

put '/tasks/:task_id/solutions/:id' do |task_id, id|
  admins_only

  points = params[:points]
  Solution.find(id).update(points: points)

  redirect to "/tasks/#{task_id}/solutions/#{id}"
end
