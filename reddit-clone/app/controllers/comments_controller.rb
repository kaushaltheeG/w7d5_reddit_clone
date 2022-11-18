class CommentsController < ApplicationController
    before_action :require_logged_in, only: [:new, :create]
    def new 
        @comment = Comment.new
        render :new 
    end 

    def create 
        @comment = Comment.new(comment_params)
        @comment.author_id = current_user.id 
        # @comment.post_id = params[:post_id]
        debugger
        if @comment.save 
            redirect_to post_url(@comment.post_id)
        else 
            flash[:errors] = @comment.errors.full_messages
            render :new 
        end 
    end 

    # def show 
    #     @comment = Comment.find_by(id: params[:id])
    #     if @comment
    #         render :show 
    #     else
    #         redirect_to subs_url  
    #     end 
    # end 

    private 

    def comment_params
        params.require(:comment).permit(:body, :post_id)
    end 
end
