class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :project_check, only: [:show]
  
  def index
    # @projects = Project.all
    @projects = Project.search(params[:search]).paginate(page: params[:page], per_page: 5)
  end

  def show
    @project = Project.find(params[:id])
  end
  
  def new
    @project = Project.new
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
    def project_check
      @project = Project.find_by(id: params[:id])
      redirect_to root_path unless @project 
    end

    def project_params
      params.require(:project).permit(:name, :description, :start_date, :end_date, :team_id)
    end
end
