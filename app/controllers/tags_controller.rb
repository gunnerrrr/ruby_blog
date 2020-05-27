class TagsController < ApplicationController
    def index
        @tags= Post.all

    end
    def show
        @tag = Tag.find_by(name: params[:id])
        @tags =@tag.posts.order(created_at: 'DESC')
    end
end