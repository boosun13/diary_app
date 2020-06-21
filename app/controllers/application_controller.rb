class ApplicationController < ActionController::Base
    before_action :index

    # GET /blogs
    # GET /blogs.json
    def index
        @blogs = Blog.all.order(id: "DESC")
    end
end
