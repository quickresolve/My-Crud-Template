#show all users
get '/users' do
	@users = User.all
	erb :'/users/user_index'
end

#new user form
get '/users/new' do
	erb :'/users/user_new'
	# if request.xhr?
	# 	erb :'/users/_new_user_form', layout: false
	# else
	# 	erb :'/users/user_new'
	# end
end

#create new user
post '/users' do
  new_user = User.new(username: params[:username], email: params[:email] , password: params[:password])
  if new_user.valid?
  	new_user.save
  	login(new_user)
  	new_user_success_message
  	redirect "/"
  else
  	# status 400
		# flash[:errors] = user.errors.full_messages
		redirect '/users/new'
  end
end

#show a user
get '/users/:id' do
	 @user = current_user
	 erb :'users/user_show'
end

#get edit page
get '/users/:id/edit' do
	@user = current_user
	erb :'/users/user_edit'
	# if request.xhr?
	# 	erb :'/users/_edit_user_form', layout: false
	# else
	# 	erb :'/users/user_edit'
	# end
end

#submit user edit
put '/users/:id' do
	user = current_user
	user.username = params[:username]
	user.email = params[:email]
	if user.save
		redirect '/'
	else
		# flash[:errors] = user.errors.full_messages
		redirect "/users/#{current_user.id}/edit"
	end
end

#delete user
delete '/users/:id' do
  user = current_user
  user.destroy
  logout!
  redirect '/'
end


