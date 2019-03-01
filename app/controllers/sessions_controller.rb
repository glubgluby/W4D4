class SessionsController < ApplicationController


    def new #new_session_url GET
        @user = User.new
        render :new
    end

    def create #session_url POST
        @user = User.find_by_credentials(params[:user][:email],params[:user][:password])
        unless @user
            flash.now[:errors] = ['invalid email/password']
            render :new
        else
            login!(@user)
            redirect_to user_url(@user)
        end
    end

    def destroy #session_url DESTROY
        logout!
    end


end