class CreateTransactionHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :transaction_histories do |t|
      t.bigint :user_id, null: false
      t.integer :kind, null: false
      t.decimal :money, null: false
      t.integer :lock_version, null: false, default: 0

      t.timestamps
    end
  end
end
