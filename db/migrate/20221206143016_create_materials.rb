class CreateMaterials < ActiveRecord::Migration[7.0]
  def change
    create_table :materials, id: :uuid do |t|
      t.string :title
      t.string :slug
      t.string :materialIcon
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
