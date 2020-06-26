class ApplicationController < ActionController::Base
    before_action :blogs_index

    # GET /blogs
    # GET /blogs.json
    def blogs_index
        @new_blogs = Blog.all.order(id: "DESC")
    end
end
