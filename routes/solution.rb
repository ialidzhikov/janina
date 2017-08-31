require 'coderay'
require 'github/markup'

get '/tasks/:task_id/solutions/:id' do |_, id|
  @solution = Solution.find(id)
  if student? && @solution.user_id != session[:id] && !@solution.task.closed?
    redirect back
  end

  code = @solution.last_submission.code

  @lines = CodeRay.scan(code, :ruby).html(wrap: nil).split("\n")

  erb :'solutions/show'
end

get '/tasks/:id/solutions' do |id|
  @task = Task.find(id)
  redirect back if student? && !@task.closed?

  erb :'solutions/index'
end

post '/tasks/:id/solutions', allow: :user do |id|
  @task = Task.find(id)
  @code = params[:code]

  solution = Solution.find_or_create_by(user_id: session[:id], task_id: id)
  Submission.create(solution_id: solution.id, code: @code)

  erb :'my_solution/show'
end

put '/tasks/:task_id/solutions/:id', allow: :admin do |task_id, id|
  points = params[:points]
  Solution.find(id).update(points: points)

  redirect to "/tasks/#{task_id}/solutions/#{id}"
end
