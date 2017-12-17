class AddImageToProduct < ActiveRecord::Migration[5.1]
  def self.up
    add_attachment :products, :image
  end

  def self.down
    remove_attachment :products, :image
  end
end
