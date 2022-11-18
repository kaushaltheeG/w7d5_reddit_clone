class PostsController < ApplicationController

    before_action :require_logged_in, only: [:new, :create, :edit, :update]

    def new
        @post = Post.new 
        render :new 
    end

    def create
        @post = Post.new(post_params)
        @post.author_id = current_user.id 
        @post.sub_id = params[:sub_id]

        if @post.save 

        else 
            flash[:errors] = @post.errors.full_messages
            render :new 
        end 
    end

    def edit
    end

    def update
    end

    def show
    end

    private 
    def post_params 
        params.require(:post).permit(:title, :url, :content)
    end 
end
