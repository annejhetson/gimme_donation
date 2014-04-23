class StudentsController < ApplicationController

before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def show
    @charge = Charge.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      render "index"
    end
  end

  def update
    if @student.update
      flash[:notice] = "#{@student.name} was updated"
      redirect_to :back
    else
      flash[:alert] = "ERRORRRRRRRR!!!!"
      render 'show'
    end
  end

  def edit
  end

  def destroy
    @student.destroy
    flash[:notice] = "We kicked her/him out successfully! Yay!"
    redirect_to "index"
  end


  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name)
  end

end
