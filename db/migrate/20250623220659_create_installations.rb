class CreateInstallations < ActiveRecord::Migration[7.0]
  def change
    create_table :installations do |t|
      t.string :customer_name
      t.string :address
      t.datetime :starts_at
      t.datetime :ends_at
      t.references :technician, null: false, foreign_key: true

      t.timestamps
    end
  end
end
