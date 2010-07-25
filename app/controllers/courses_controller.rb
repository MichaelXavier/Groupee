class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.xml
  def index
    @courses = current_user.courses

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.xml
  def show
    @group = current_user.courses.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.xml
  def new
    @course = current_user.courses.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = current_user.courses.find(params[:id])
  end

  # POST /courses
  # POST /courses.xml
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        @course.add_student(current_user)
        format.html { redirect_to(@course, :notice => 'Course was successfully created.') }
        format.xml  { render :xml => @course, :status => :created, :location => @course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    @course = current_user.courses.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to(@course, :notice => 'Course was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  def remove_student
    @course = current_user.courses.find(params[:id])

    student = User.find(params[:student_id])
    @course.students.delete(student)

    respond_to do |format|
      format.html { redirect_to(edit_course_path(@course), :notice => "Student #{student.full_name} was successfully removed from the course.") }
      format.xml  { head :ok }
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.xml
  def destroy
    raise NotImplementedError, "Destroy functionality not yet implemented."
    #@course = Course.find(params[:id])
    #@course.destroy

    #respond_to do |format|
    #  format.html { redirect_to(courses_url) }
    #  format.xml  { head :ok }
    #end
  end
end
