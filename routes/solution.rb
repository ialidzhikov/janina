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
