class CitytownsController < ApplicationController
   before_action :authenticate_user!
  before_action :set_citytown, only: %i[ show edit update destroy ]

  # GET /citytowns or /citytowns.json
  def index
    @citytowns = Citytown.all
  end

  # GET /citytowns/1 or /citytowns/1.json
  def show
  end

  # GET /citytowns/new
  def new
    @citytown = Citytown.new
  end

  # GET /citytowns/1/edit
  def edit
  end

  # POST /citytowns or /citytowns.json
  def create
    @citytown = current_user.citytowns.build(citytown_params)

    respond_to do |format|
      if @citytown.save
        format.html { redirect_to setting_path, notice: "Citytown was successfully created." }
        format.json { render :show, status: :created, location: @citytown }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @citytown.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /citytowns/1 or /citytowns/1.json
  def update
    respond_to do |format|
      if @citytown.update(citytown_params)
        format.html { redirect_to citytown_url(@citytown), notice: "Citytown was successfully updated." }
        format.json { render :show, status: :ok, location: @citytown }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @citytown.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /citytowns/1 or /citytowns/1.json
  def destroy
    @citytown.destroy

    respond_to do |format|
      format.html { redirect_to citytowns_url, notice: "Citytown was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_citytown
      @citytown = Citytown.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def citytown_params
      params.require(:citytown).permit(:title, :slug, :user_id)
    end
end
