class ChangeDataMessageToNotification < ActiveRecord::Migration[5.2]
  def change
    change_column :notifications, :message, :text
  end
end
