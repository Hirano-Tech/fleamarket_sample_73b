class AddSalerToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :saler, :integer
    add_column :items, :buyer, :integer
  end
end
