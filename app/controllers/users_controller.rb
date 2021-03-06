class UsersController < ApplicationController
  before_action :authenticate_user, {only:[:index, :show, :edit, :update ]}
  before_action :ensure_correct_user , {only: [:edit, :update, :destroy]}
  
  def index
    @users = User.search(params[:search]).paginate(page: params[:page], per_page: 5)
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(name: params[:name],
      email: params[:email],
      password: params[:password],
      image_name: "noimage.png"
    )
    if params[:password] != params[:password2]
      flash[:error] = "パスワードを一致させてください"
      render ("users/new")
      flash[:error] = nil
    else
      if @user.save
        session[:user_id] = @user.id
        redirect_to ("/users"), notice: 'User was successfully created.'
      else
        render ("users/new")
      end
    end
  end

  def edit
    @user = User.find_by(id: [params[:id]])
  end

  def update
    @user = User.find_by(id: [params[:id]])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]

    if params[:password] != params[:password2]
      flash[:error] = "パスワードを一致させてください"
      render ("users/new")
      flash[:error] = nil
    else
      if params[:image]
        if params[:image] == "reset"
          @user.image_name = "noimage.png"
        else
          perms = ['.jpg','.jpeg','.gif','.png']
          @user.image_name = "#{@user.id}.jpg"
          image = params[:image]
          File.open("public/user_images/#{@user.image_name}", 'wb') { |f| f.write(image.read) }
        end
      end
      
      
      if @user.save
        redirect_to ("/users"), notice: 'User was successfully updated.'
      else
        render ("/users/edit") 
      end
    end
  end


  def destroy
    @user = User.find_by(id: [params[:id]])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to "/users", notice: 'Blog was successfully destroyed.' }
    end
  end
  
  def login_form
  end
  
  def login
    @user = User.find_by(email: params[:email],
      password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to ("/blogs")
      flash[:success] = 'Login succeeded. Hello World !'
    else
      flash[:error] = "Email address or password is error"
      render ("/users/login_form")
      flash[:error] = nil
      
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to ("/login"), notice: 'Logout succeeded. See you !'
  end


  def ensure_correct_user
    @user = User.find_by(id: [params[:id]])
    if @user.id != @current_user.id
      redirect_to ("/users")
      flash[:error] = "他のユーザーです"
    end
  end

end
