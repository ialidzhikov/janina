get '/tasks/:id/my_solution', allow: :user do |id|
  @task = Task.find(id)
  solution = Solution.find_by(user_id: session[:id], task_id: id)
  @code = solution.code if solution

  erb :'my_solution/show'
end
