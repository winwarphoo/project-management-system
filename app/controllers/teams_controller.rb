class TeamsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :team_check, only: [:show]
  def index
    @test = "チーム一覧を見る"
    @teams = Team.search(params[:search]).paginate(page: params[:page], per_page: 5)
  end

  def search
    @model = params["model"]
    @content = params["content"]
    @records = search_for(@model, @content)
  end

  def show
    @team = Team.find(params[:id])
    @member = Member.new
  end

  def member_add
    @team = Team.find(params[:team_id])
    @member = Member.new
  end

  def new
    @team = Team.new
    # @member = Member.new
  end

  def create
    @team = Team.new(team_params)
    @team.user_id = current_user.id
    if @team.save
      flash[:notice] = "チームの作成は正常に完了しました。"
      redirect_to("/teams/#{@team.id}/member_add")
    else
      flash.now[:alert] = "チームの作成は異常に完了しました。"
      render("teams/new")
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      flash[:notice] = "チームの更新は正常に完了しました。"
      redirect_to("/teams/#{@team.id}/member_add")
    else
      flash.now[:alert] = "チームの更新は異常に完了しました。"
      render("teams/edit")
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    flash[:notice] = "チームの削除は正常に完了しました。"
    redirect_to("/teams")
  end

  private

    def team_check
      @team = Team.find_by(id: params[:id])
      redirect_to root_path unless @team 
    end

    def team_params
      params.require(:team).permit(:name)
    end

    def member_params
      params.require(:member).permit(:name, :email)
    end

    # def search_for(model, content)
    #   if model == 'team'
    #     Team.where(name: content)
    #   else
    #     Team.where('name LIKE ?', '%'+content+'%')
    #   end
    # end
end
