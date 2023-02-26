class AddColumnToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :metadata, :json
  end
end
