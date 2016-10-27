class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.text :description
      t.boolean :done
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
