
class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(group_params)
    if @group.save
      redirect_to root_path, notice: 'グループが作成されました'
    else
      flash.now[:alert] = "グループ名を入力してください"
      render :action => :new
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, { user_ids:[] })
  end
end
