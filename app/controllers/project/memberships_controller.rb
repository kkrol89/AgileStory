class Project::MembershipsController < Project::BaseController
  include Authorization::Login
  before_filter :authorize_browse, only: [:index]
  before_filter :authorize_manage, only: [:new, :create, :edit, :update, :destroy]

  def new
    @membership = project.memberships.build
  end
  
  def create
    @membership = project.memberships.build(params[:membership])
    if @membership.save
      redirect_to project_memberships_path(project), :notice => 'Member successfully assigned'
    else
      render :new
    end
  end

  def edit
    @membership = project.memberships.find(params[:id])
  end

  def update
    @membership = project.memberships.find(params[:id])
    if @membership.update_attributes(params[:membership])
      redirect_to project_memberships_path(project), :notice => I18n.t('membership_successfully_updated')
    else
      render :edit
    end
  end

  def index
    @memberships = Membership.where(:project_id => params[:project_id])
  end

  def destroy
    project.memberships.find(params[:id]).destroy
    redirect_to project_memberships_path(project), :notice => I18n.t('membership_successfully_deleted')
  end

  private
  def authorize_browse
    authorize! :browse_memberships, project
  end

  def authorize_manage
    authorize! :manage_memberships, project
  end
end
