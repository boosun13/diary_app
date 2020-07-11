class BlogsController < ApplicationController
  before_action :authenticate_user, {only:[:index, :show, :edit, :update, :new ]}
  before_action :ensure_correct_user , {only: [:edit, :update, :destroy]}
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :blogs_index


  def blogs_index
    if params[:user].to_i == @current_user.id || params[:user] == nil
      @user = User.find_by(id: @current_user[:id])
      @new_blogs = @user.blogs.all.order(created_at: :desc)
    else
      @user = User.find_by(id: params[:user])
      @new_blogs = @user.blogs.where(range: nil).order(created_at: :desc)
    end
    # @new_blogs = Blog.where(user_id: params[:id])
    
    @memo = Memo.find_by(user_id: @current_user.id)

  end

  # GET /blogs
  # GET /blogs.json
  def index
    if @current_user.id == @user.id
      @blogs = @user.blogs.all.order(created_at: :desc).paginate(page: params[:page], per_page: 5)      
    else
      @blogs = @user.blogs.where(range: nil).order(created_at: :desc).paginate(page: params[:page], per_page: 5)      
      
    end
  end
  
  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blog = Blog.find_by(id: params[:id])
    if @blog.range != nil
      if @blog.user_id == @current_user.id
      else
        redirect_to ("/blogs"), notice: "IDエラー"
      end
    end

    @comment_index = Comment.where(blog_id: params[:id])
  end

  def search
  end


  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = @current_user.id
    @blog.start_time = @blog.created_at

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    @blog.start_time = @blog.created_at
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title, :content, :user_id, :range) 
    end

    def ensure_correct_user
      @blog = Blog.find_by(id: params[:id])
      if @blog.user_id != @current_user.id
        redirect_to ("/blogs"), notice: "他のユーザーです"
      end
    end
end
