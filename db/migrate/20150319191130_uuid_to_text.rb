class UuidToText < ActiveRecord::Migration
  def up
    remove_index(:weblogs, name: "user_and_uuid")
    change_column(:weblogs, :uuid, :text)
  end
end
