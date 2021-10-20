class ProjectsController < ApplicationController

  def index
    # @projects = Project.all
    @projects = Project.paginate(page: params[:page], per_page: 3)
  end

  def show
    @project = Project.find(params[:id])
  end
  
  def new
    @project = Project.new
    # @teams = Team.select(:id, :name)
    # @teams = Team.where('id = ?', '3').select( "name")
  end

  def create
    @project = Project.new(project_params)
    #@project.team_id = params[:team_id]
    if @project.save
      flash[:notice] = "プロジェクトの作成は正常に完了しました。"
      redirect_to("/projects/#{@project.id}")
    else
      flash.now[:alert] = "プロジェクトの作成は異常に完了しました。"
      render("projects/new")
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:notice] = "プロジェクトの更新は正常に完了しました。"
      redirect_to("/projects/#{@project.id}")
    else
      flash.now[:alert] = "プロジェクトの更新は異常に完了しました。"
      render("projects/edit")
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "プロジェクトの削除は正常に完了しました。"
    redirect_to("/projects")
  end

  private
    def project_params
      params.require(:project).permit(:name, :description, :start_date, :end_date, :team_id)
    end
end
