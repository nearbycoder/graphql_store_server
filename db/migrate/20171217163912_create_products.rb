class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description, null: false

      t.timestamps
    end

    add_column :products, :deleted_at, :datetime
    add_index :products, :deleted_at
  end
end
