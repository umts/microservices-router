class AddServiceIdToModels < ActiveRecord::Migration[5.0]
  def change
    add_column :models, :service_id, :integer
  end
end
