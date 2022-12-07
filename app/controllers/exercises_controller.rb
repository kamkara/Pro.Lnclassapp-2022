class ExercisesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: %i[new create]
  before_action :set_exercise, only: %i[ show edit update destroy ]

  # GET /exercises or /exercises.json
  def index
    @exercises = Exercise.all
  end

  # GET /exercises/1 or /exercises/1.json
  def show
  end

  # GET /exercises/new
  def new
    @exercise = @course.exercises.build
  end

  # GET /exercises/1/edit
  def edit
  end

  # POST /exercises or /exercises.json
  def create
    @exercise = @course.exercises.build(exercise_params)
    @exercise.user_id = current_user.id

    if @exercise.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Exercise was successfully created." }
        format.turbo_stream
      end
      else
        render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /exercises/1 or /exercises/1.json
  def update
    respond_to do |format|
      if @exercise.update(exercise_params)
        format.html { redirect_to exercise_url(@exercise), notice: "Exercise was successfully updated." }
        format.json { render :show, status: :ok, location: @exercise }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercises/1 or /exercises/1.json
  def destroy
    @exercise.destroy

    respond_to do |format|
      format.html { redirect_to exercises_url, notice: "Exercise was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise
      @exercise = Exercise.friendly.find(params[:id])
    end

    def set_course
      @course = Course.friendly.find(params[:course_id])
    end

    # Only allow a list of trusted parameters through.
    def exercise_params
      params.require(:exercise).permit(:title, :content, :correction, :slug, :course_id, :user_id,
      questions_attributes:[:_destroy,:id, :question_type, :name, 
          answers_attributes: [:_destroy, :id, :name]])
    end
end
