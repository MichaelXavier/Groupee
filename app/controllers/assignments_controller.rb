class AssignmentsController < ApplicationController
  before_filter :find_course
  # GET /assignments
  # GET /assignments.xml
  def index
    @assignments = @course.assignments

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assignments }
    end
  end

  # GET /assignments/1
  # GET /assignments/1.xml
  def show
    @assignment = @course.assignments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assignment }
    end
  end

  # GET /assignments/new
  # GET /assignments/new.xml
  def new
    @assignment = @course.assignments.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assignment }
    end
  end

  # GET /assignments/1/edit
  def edit
    @assignment = @course.assignments.find(params[:id])
  end

  # POST /assignments
  # POST /assignments.xml
  def create
    @assignment = @course.assignments.build(params[:assignment])

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to(course_assignment_path(@course, @assignment), :notice => 'Assignment was successfully created.') }
        format.xml  { render :xml => @assignment, :status => :created, :location => @assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /assignments/1
  # PUT /assignments/1.xml
  def update
    @assignment = @course.assignments.find(params[:id])

    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        format.html { redirect_to(course_assignment_path(@course, @assignment), :notice => 'Assignment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.xml
  def destroy
    @assignment = @course.assignments.find(params[:id])
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to(course_assignments_url(@course)) }
      format.xml  { head :ok }
    end
  end

private
  def find_course
    @course = Course.find(params[:course_id])
  end
end
