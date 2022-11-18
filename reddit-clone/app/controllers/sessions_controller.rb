class SessionsController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if @user
            login(@user)
            redirect_to subs_url
        else
            flash[:errors] = ["Invalid username or password"]
            @user = User.new(params[:user][:username], params[:user][:password])
            render :new
        end
    end

    def destroy
        logout if logged_in?
        redirect_to new_session_url
    end
end
