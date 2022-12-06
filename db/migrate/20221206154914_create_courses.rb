class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses, id: :uuid do |t|
      t.string :title, null: false
      t.string :level_name, null: false
      t.string :material_name, null: false
      t.string :status
      t.string :slug, null: false
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
