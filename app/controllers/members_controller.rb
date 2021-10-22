class MembersController < ApplicationController

  def index
    @team = Team.find(params[:team_id])
  end

  def create
    @member = Member.new(member_params)
    @member.team_id = params[:team_id]
    if @member.save
      flash[:notice] = "メンバーを正常に追加しました。"
      redirect_to("/teams/#{params[:team_id]}/members")
    else
      @team = Team.find(params[:team_id])
      flash.now[:alert] = "失敗！"
      render "teams/show"
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    flash[:notice] = "メンバーの削除は正常に完了しました。"
    redirect_to("/teams")
  end

  private
    def member_params
      params.require(:member).permit(:name, :email)
    end
end
