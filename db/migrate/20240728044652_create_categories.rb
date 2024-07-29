class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_enum :category_states, %w[active inactive]

    create_table :categories do |t|
      t.string :name
      t.references :vertical, null: false, foreign_key: true
      t.enum :state, enum_type: :category_states, null: false, default: 'active'

      t.timestamps
    end
  end
end
