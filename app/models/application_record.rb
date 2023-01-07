class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  #Enables implicit order column for UUID
  self.implicit_order_column = "created_at"

  scope :ordered, -> { order('created_at desc')}
  scope :feed, -> {where("status= ?", "Lune")}
  scope :feed_exercise, -> {where("status= ?", "Lune")}

  #refactory order items
  scope :student, -> { where("status = ?", "Student").order("created_at desc")}
  scope :select_level, -> { where("level = ?", current_user.level_name)}
  scope :daily_sign_up, -> { where("created_at >= ?", Time.zone.now.beginning_of_day)}
  scope :allOrderDesc, -> { all.order('created_at desc')}
  scope :orderAsc, -> { order('created_at asc')}

end
