class PostsController < ApplicationController

  before_action :authenticate_user!, :only =>[:new, :ceate]

  def edit
    find_group
  end

  def update
    find_group
    @post.user = current_user

    if @post.update(post_params)
      redirect_to account_posts_path, notice: "编辑成功"
    else
      render :edit
    end
  end

  def destroy
    find_group
    @post.destroy
    flash[:alert] = "删除成功"
    redirect_to account_posts_path
  end

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  private

  def find_group
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @post.group = @group
  end

  def post_params
    params.require(:post).permit(:content)
  end

end
