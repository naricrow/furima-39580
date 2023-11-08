class AddTimestampsToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :created_at, :datetime, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    add_column :items, :updated_at, :datetime, null: false, default: -> { 'CURRENT_TIMESTAMP' }
  end
end

