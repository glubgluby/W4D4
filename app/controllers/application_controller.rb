class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_user, :logged_in?


    def login!(user)
        session[:session_token] = user.reset_session_token!
    end
    
    def current_user
        return nil if session[:session_token].nil?
        User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!current_user
    end

    def logout!

        if logged_in?
            current_user.reset_session_token!
            session[:session_token] = nil
            redirect_to :new_session
        end
    end

    def ensure_logged_in
        flash.now[:error] = ["You must be logged in to do that!"]
        redirect_to :new_session_url unless logged_in?
    end
end
