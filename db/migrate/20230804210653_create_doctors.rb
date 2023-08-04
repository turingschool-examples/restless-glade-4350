class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.references :hospital, null: false, foreign_key: true
      t.string :name
      t.string :specialty
      t.string :university

      t.timestamps
    end
  end
end
