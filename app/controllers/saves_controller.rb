class SavesController < ApplicationController
    before_action :find_post
    before_action :find_save, only: [:destroy]
    def create
        if already_saved?
          flash[:notice] = "Already saved :)"
        else
          @post.saves.create(user_id: current_user.id)
        end
        redirect_to post_path(@post)
    end
    def destroy
        if !(already_saved?)
          flash[:notice] = "Cannot unsave :("
        else
          @safe.destroy
        end
        redirect_to post_path(@post)
    end

  private
  def find_post
    @post = Post.find(params[:post_id])
  end
  def find_save
    @safe = @post.saves.find(params[:id])
 end
 def already_saved?
    Safe.where(user_id: current_user.id, post_id:
    params[:post_id]).exists?
  end
end