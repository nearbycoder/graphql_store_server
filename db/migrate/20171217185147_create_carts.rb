class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.belongs_to :user, index: true, null: false
      t.string :name, null: false
      t.boolean :active, null: false, default: true
      t.integer :total_price, null: false, default: 0
      t.timestamps
    end

    add_column :carts, :deleted_at, :datetime
    add_index :carts, :deleted_at
  end
end
