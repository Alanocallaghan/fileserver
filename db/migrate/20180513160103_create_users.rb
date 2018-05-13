class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email, unique: true
      t.string :authentication_token
      t.string :password_digest

      t.timestamps null: false

      t.index :authentication_token, unique: true
    end
  end
end
