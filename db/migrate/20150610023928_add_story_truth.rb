class AddStoryTruth < ActiveRecord::Migration
  def change
    add_column :stories, :truth, :boolean, :default => true
  end
end
