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
            redirect_to post_url(@post)
            params[:post][:sub_ids].each_with_index do |sub_id|
                sub_id_int = sub_id.to_i
                PostSub.create(sub_id: sub_id_int, post_id: @post.id) unless sub_id_int.zero?
            end
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
