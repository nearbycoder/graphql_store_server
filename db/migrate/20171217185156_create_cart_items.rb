class CreateCartItems < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_items do |t|
      t.belongs_to :cart, index: true, null: false
      t.integer :quantity, null: false
      t.timestamps
    end

    add_reference :cart_items, :variant, foreign_key: true
    add_column :cart_items, :deleted_at, :datetime
    add_index :cart_items, :deleted_at
  end
end
