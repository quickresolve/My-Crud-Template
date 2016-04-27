helpers do
  def new_user_success_message
    session[:success] = "Account successfully created"
  end

  def login(user)
    session[:user_id] = user
  end

  def logout!
    session.clear
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
     session[:user_id].present?
  end

  def set_login_success_message
   session[:success] =  "Successfully Logged In"
  end

  def set_logout_success_message
   session[:success] =  "Successfully Logged Out"
  end

  def set_error_message
   session[:error] = "Email or password does not match records"
  end

  def allow_edit(post)
    if session[:id] == post.user_id
      return true
    else
      return false
    end
  end
end