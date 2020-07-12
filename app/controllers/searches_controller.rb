class SearchesController < ApplicationController

    def index
        @blogs = Blog.where(range: nil).search(params[:search]).order(created_at: :desc).paginate(page: params[:page], per_page: 5)
    end

    def search_blogs
        @blogs = Blog.search(params[:search]).order(created_at: :desc).paginate(page: params[:page], per_page: 5)
    end

    def search_users
        
    end

end
