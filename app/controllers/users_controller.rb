class UsersController < ApplicationController

  def index
    @users = User.all.
    paginate(page: params[:page], per_page: 3)
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
    if @user.save
      redirect_to ("/users"), notice: 'User was successfully created.'
    else
      render ("users/new")
    end
  end

  def edit
    @user = User.find_by(id: [params[:id]])
  end

  def update
    @user = User.find_by(id: [params[:id]])
    @user.name = params[:name]
    @user.email = params[:email]

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


  def destroy
    @user = User.find_by(id: [params[:id]])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to "/users", notice: 'Blog was successfully destroyed.' }
    end
  end
end
