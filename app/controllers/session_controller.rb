#create new session page
get '/login' do
	erb :'/sessions/session_new'
	# if request.xhr?
	# 	erb :'/sessions/_new_session_form', layout: false
	# else
	# erb :'/sessions/session_new'
	# end
end

#login to session
post '/sessions' do
  access = User.authenticate(params[:email], params[:password])
  if access
    user_id = User.find_by(email: params[:email]).id
    puts "This is the user id:" + user_id.to_s
    login(user_id)
    set_login_success_message
    puts session[:user_id]
    redirect "/users/#{session[:user_id]}"
  else
    set_error_message
    redirect '/'
  end
end


#delete session
get '/logout' do
  logout!
  set_logout_success_message
  redirect '/'
end


