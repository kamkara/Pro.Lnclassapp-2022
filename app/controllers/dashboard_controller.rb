class DashboardController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @StudentList = User.all.ordered
  end

  def home
    @LevelList = Level.all.ordered
    @CityList = Citytown.all.ordered
    @MaterialList = Material.all.ordered
    @SchoolList = School.all.ordered
  end
end
