class CommentsController < ApplicationController
    def create
        @comment = Comment.new(content: params[:comment],
            user_id: @current_user.id,
            blog_id: params[:blog_id])
        if @comment.save
            @blog = Blog.find_by(id: params[:blog_id])
            @comment_index = Comment.where(blog_id: params[:blog_id])
            render :show
        else
            redirect_to ("/blogs"), notice: "投稿できませんでした"
        end
    end

    def destroy
        @comment = Comment.find_by(id: params[:id])
        blog_id = @comment.blog_id
        if @comment.destroy
            @blog = Blog.find_by(id: blog_id)
            @comment_index = Comment.where(blog_id: blog_id)
            render :show
        end
    end
end
