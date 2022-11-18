class SubsController < ApplicationController

    before_action :require_logged_in, only: [:new, :create]

    def new
        @sub = Sub.new
        render :new
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.moderator_id = current_user.id
        # debugger
        if @sub.save
            redirect_to sub_url(@sub)
        else
            flash[:errors] = @sub.errors.full_messages
            render :new
        end
    end

    def show
        @sub = Sub.find_by(id: params[:id])
        if @sub
            render :show
        else
            redirect_to subs_url
        end
    end

    def index
        @subs = Sub.all
        render :index
    end

    private
    def sub_params
        params.require(:sub).permit(:title, :description)
    end
end
