class CreateChatAttachements < ActiveRecord::Migration
  def change
    create_table :chat_attachements do |t|
      t.integer :chat_id
      t.integer :user_id
      t.string :attachement_file_name
      t.string :attachement_content_type
      t.integer :attachement_file_size
      t.datetime :attachement_updated_at

      t.timestamps
    end
  end
end
