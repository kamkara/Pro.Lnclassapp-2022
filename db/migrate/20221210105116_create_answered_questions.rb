class CreateAnsweredQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :answered_questions, id: :uuid do |t|
      t.belongs_to :answer, null: false, foreign_key: true, type: :uuid
      t.belongs_to :question, null: false, foreign_key: true, type: :uuid
      t.belongs_to :result, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
