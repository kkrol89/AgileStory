class CreateTicketAttachements < ActiveRecord::Migration
  def change
    create_table :ticket_attachements do |t|
      t.integer :ticket_id
      t.string :attachement_file_name
      t.string :attachement_content_type
      t.integer :attachement_file_size
      t.datetime :attachement_updated_at
      t.timestamps
    end
  end
end
