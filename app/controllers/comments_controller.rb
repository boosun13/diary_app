class CommentsController < ApplicationController
    def create
        @comment = Comment.new(content: params[:comment],
            user_id: @current_user.id,
            blog_id: params[:blog_id])
        if @comment.save
            redirect_to ("/blogs"), notice: "投稿しました。"
        else
            redirect_to ("/blogs"), notice: "投稿できませんでした"
        end
    end

    def update
    end

    def destroy
    end
end
