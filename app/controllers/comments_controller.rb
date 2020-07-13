class CommentsController < ApplicationController
    def create
        @comment = Comment.new(content: params[:comment],
            user_id: @current_user.id,
            blog_id: params[:blog_id])
        if @comment.save
            @blog = Blog.find_by(id: params[:blog_id])
            @comment_index = Comment.where(blog_id: params[:blog_id])
            flash[:notice] = "コメントを投稿しました。"
            render :show 
            flash[:notice] = nil
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
            flash[:notice] = "コメントを削除しました。"
            render :show
            flash[:notice] = nil
        end
    end
end
