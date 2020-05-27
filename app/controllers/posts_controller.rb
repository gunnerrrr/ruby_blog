class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_post, only:[:show, :edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update, :destroy]
    def index
        @posts = Post.all
    end

    def show 
       
     end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params.merge(user_id: current_user.id))
        @post.user = current_user
        if @post.save
            flash.now[:success] = 'Post was created successfully :)'
            render :show
        else
            flash.now[:danger] = 'Sorry, Post was not created :('
            render :new
        end
    end
    def edit
    end
    
    def update       
        if @post.update_attributes(post_params)
            flash.now[:success] = 'Post was updated :)'
            render :show
        else 
            flash.now[:danger] = 'Post was not updated :('
            render :edit
        end

    end

    def destroy
        @post.destroy
        flash.now[:success] = 'Post was deleted :)'
        redirect_to root_path

    end

    def user_saves
        @posts =  Post.select{ |s|  s.saves.find { |safe| safe.user_id == current_user.id}};
        render :user_saves
    end

    private
    def post_params
        params.require(:post).permit(:title, :author,:summary, :body, :post_tags)
    end
    def set_post
        @post = Post.find(params[:id])
    end
    def correct_user
        redirect_to root_path, notice: 'You are not allowed to modify this post' unless current_user.id == @post.user_id
    end
end
