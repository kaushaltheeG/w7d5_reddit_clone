class PostsController < ApplicationController

    before_action :require_logged_in, only: [:new, :create, :edit, :update]

    def new
        @post = Post.new 
        render :new 
    end

    def create
        @post = Post.new(post_params)
        @post.author_id = current_user.id
        if @post.save 
            @post.update(sub_ids: params[:post][:sub_ids][1..-1])
            redirect_to post_url(@post)
        else 
            flash[:errors] = @post.errors.full_messages
            render :new 
        end 
    end

    def edit
        @post = Post.find_by(id: params[:id])
        render :edit 
    end

    def update
        @post = Post.find_by(id: params[:id])

        if @post.update(post_params)
            @post.update(sub_ids: params[:post][:sub_ids][1..-1])
            redirect_to post_url(@post)
        else 
            flash[:errors] = @post.errors.full_messages
            render :edit 
        end
    end

    def show
        @post = Post.find_by(id: params[:id])
        if @post
            render :show
        else
            redirect_to subs_url
        end
    end

    private 
    def post_params 
        params.require(:post).permit(:title, :url, :content, :sub_ids)
    end 
end
