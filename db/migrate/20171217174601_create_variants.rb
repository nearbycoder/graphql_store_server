class CreateVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :variants do |t|
      t.string :name, null: false
      t.string :description
      t.integer :price, null: false
      t.belongs_to :product, index: true, null: false
      t.timestamps
    end

    add_column :variants, :deleted_at, :datetime
    add_index :variants, :deleted_at
  end
end
