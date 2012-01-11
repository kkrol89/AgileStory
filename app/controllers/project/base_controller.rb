class Project::BaseController < ApplicationController
  def project
    @project ||= Project.find(params[:project_id])
  end
end