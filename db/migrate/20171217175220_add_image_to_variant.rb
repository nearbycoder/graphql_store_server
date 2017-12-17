class AddImageToVariant < ActiveRecord::Migration[5.1]
  def self.up
    add_attachment :variants, :image
  end

  def self.down
    remove_attachment :variants, :image
  end
end
