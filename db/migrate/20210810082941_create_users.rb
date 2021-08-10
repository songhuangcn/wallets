class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.decimal :balance, null: false, default: 0
      t.integer :lock_version, null: false, default: 0

      t.timestamps
    end
  end
end
