class DashboardController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @StudentList = User.all.ordered
      respond_to do |format|
        format.xlsx {
          response.headers[
            'Content-Disposition'
          ] = "attachment; filename=UserLnclass-#{DateTime.now.strftime("%d%m%Y%H%M")}.xlsx"
        }
        format.html { render :index }
      end
  
  end

  def home
    @LevelList = Level.all.ordered
    @CityList = Citytown.all.ordered
    @MaterialList = Material.all.ordered
    @SchoolList = School.all.ordered
  end
end
