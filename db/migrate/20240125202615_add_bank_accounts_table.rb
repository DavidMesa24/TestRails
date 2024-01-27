class AddBankAccountsTable < ActiveRecord::Migration[7.0]
  def up
    create_table :bank_accounts do |t|
      t.string :account_number
      t.references :bank, null: false, foreign_key: true
      t.references :provider, null: false, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :bank_accounts if table_exists? :bank_accounts
  end
end
