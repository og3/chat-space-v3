class GroupsController < ApplicationController

  before_action :set_group, only:[:show, :edit, :update]

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: 'グループが作成されました'
    else
      flash.now[:alert] = "グループ名を入力してください"
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to group_path(@group), flash: {notice: 'グループ情報が変更されました。'}
    else
      render 'edit'
      flash[:alert] = 'グループ情報の変更に失敗しました'
    end
  end

  def show
    @groups = current_user.groups
  end

  private
  def group_params
    params.require(:group).permit(:name, { user_ids:[] })
  end

  def set_group
     @group = Group.find(params[:id])
  end
end
