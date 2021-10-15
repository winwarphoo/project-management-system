class TeamsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  def index
    @test = "チーム一覧を見る"
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @member = Member.new
  end

  def new
    @team = Team.new
    # @member = Member.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:notice] = "Team create successfully!!!"
      redirect_to("/teams/#{@team.id}")
    else
      flash.now[:alert] = "Team doesn't create!!!"
      render("teams/new")
    end
  end

  # def create
  #   @team = Team.new(team_params)
  #   if @team.save
  #     @member = Member.new(member_params)
  #       if @member.save
  #         @member.team_id = @team.id
  #         redirect_to("/teams")
  #       else
  #         redirect_to("/teams/#{@team.id}")
  #       end
  #     flash[:notice] = "Team create successfully!!!"
  #     redirect_to("/teams/#{@team.id}")
  #   else
  #     flash.now[:alert] = "Team doesn't create!!!"
  #     render("teams/new")
  #   end
  # end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      flash[:notice] = "Team update successfully!!!"
      redirect_to("/teams/#{@team.id}")
    else
      flash.now[:alert] = "Team doesn't update!!!"
      render("teams/edit")
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    flash[:notice] = "Team successfully destroy!!!"
    redirect_to("/teams")
  end

  private
    def team_params
      params.require(:team).permit(:name)
    end

    def member_params
      params.require(:member).permit(:name, :email)
    end
end
