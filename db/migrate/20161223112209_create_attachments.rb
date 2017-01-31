class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.string :file_name
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end