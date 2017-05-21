class Admin::CoursesController < ApplicationController
  before_action :authenticate_user

  # Some code here
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @pending_requests = CourseStudent.where(course_id: params[:id], status: 'pending')
  end

  def approve
    CourseStudent.find(params[:request_id]).update(status: 'approved')
  end

  def new
    @course = Course.new
  end


  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:notice] = "Course is created successful"
      redirect_to admin_courses_path
    else
      flash.now[:error] = @course.errors.full_messages
      render 'new'
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :image, :description)
  end

end