module BoardsAssignment
  def self.included(klass)
    klass.instance_eval do
      before_filter :assign_boards, :only => [:show]
      before_filter :stretch_view, :only => [:show]
    end
  end

  def assign_boards
    @icebox = Icebox.where(:project_id => project.id).includes(:tickets).last
    @backlog = Backlog.where(:project_id => project.id).includes(:tickets).last
    @sprints = Sprint.where(:project_id => project.id).order('sequence_number')
    if params[:sprint_id].present?
      @sprint = Sprint.where(:project_id => project.id, :id => params[:sprint_id]).includes(:tickets).last
    else
      @sprint = Sprint.where(:project_id => project.id).order('sequence_number').includes(:tickets).last
    end
  end
  private :assign_boards

  def stretch_view
    @stretched_view = 'stretched'
  end
  private :stretch_view
end