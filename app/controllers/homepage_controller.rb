class HomepageController < ApplicationController
  
  def index
    if user_signed_in?
      @feed_materials = Material.all
    
      @pagy, @feed_courses = pagy_countless(Course.all.ordered, items: 5 )
      render "scrollable_list" if params[:page]

      #@pagy, @feed_exercises = pagy_countless(@feed_courses.exercises, items: 2 )
      #render "scrollable_list" if params[:page]
  
    end
    #redirect_to feed_path if user_signed_in?
    #redirect_to feed_path if user_signed_in? && set_home_feed == "feed"
    #redirect_to welcome_path if user_signed_in? && set_home_feed == "welcome"
  end

  private

  #def set_home_feed
    #if current_user.status == "Students" && current_user.welcomes.none?
      #return "welcome"
    #else
     #return "feed"
    #end
  #end
end
