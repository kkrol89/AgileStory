class RenameNumberToSequenceNumberInSprints < ActiveRecord::Migration
  def up
    rename_column 'sprints', 'number', 'sequence_number'
  end

  def down
    rename_column 'sprints', 'sequence_number', 'number'
  end
end
