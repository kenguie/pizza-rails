class CreateGrubbers < ActiveRecord::Migration
  def change
    create_table :grubbers do |t|
      t.string :mobile
      t.string :email
      t.string :password
      t.boolean :subscribed
      t.boolean :text_ok
      t.boolean :email_ok

      t.timestamps
    end
  end
end
