class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_enum :course_states, %w[active inactive]

    create_table :courses do |t|
      t.string :name
      t.string :author
      t.references :category, null: false, foreign_key: true
      t.enum :state, enum_type: :course_states, null: false, default: 'active'

      t.timestamps
    end
  end
end
