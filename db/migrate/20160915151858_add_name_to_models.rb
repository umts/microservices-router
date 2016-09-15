class AddNameToModels < ActiveRecord::Migration[5.0]
  def change
    add_column :models, :name, :string
  end
end
