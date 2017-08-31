post '/submissions/:id/comments', allow: :user do |id|
  Comment.create(submission_id: id, user_id: session[:id], body: params[:body])
  solution = Submission.find(id).solution

  redirect to "/tasks/#{solution.task_id}/solutions/#{solution.id}"
end
