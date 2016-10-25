class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.integer :year
      t.string :degree
      t.boolean :done
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
