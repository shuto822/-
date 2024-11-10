class CreateGroupMails < ActiveRecord::Migration[6.1]
  def change
    create_table :group_mails do |t|
      t.references :group, null: false, foreign_key: true
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
