class MemosController < ApplicationController
  def create
    @user_memo = Memo.new(content: params[:memo], user_id: @current_user.id)
    @user_memo.save
  end

  def update
    @user_memo = Memo.find_by(user_id: @current_user.id)
    @user_memo.content = params[:memo]
    @user_memo.save
  end



end
