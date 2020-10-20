class AddMessageToNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :message, :integer
  end
end
