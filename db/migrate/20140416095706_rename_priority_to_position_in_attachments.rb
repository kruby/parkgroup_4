class RenamePriorityToPositionInAttachments < ActiveRecord::Migration
  def self.up
    rename_column :attachments, :priority, :position
  end

  def self.down
    rename_column :attachments, :position, :priority
  end
  
end
