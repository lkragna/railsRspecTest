class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :user_id
      t.string :secret_key
      t.boolean :status

      t.timestamps null: false
    end
  end
end
