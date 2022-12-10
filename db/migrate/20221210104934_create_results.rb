class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results, id: :uuid do |t|
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
      t.belongs_to :exercise, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
