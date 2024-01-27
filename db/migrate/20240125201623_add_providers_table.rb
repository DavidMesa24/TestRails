class AddProvidersTable < ActiveRecord::Migration[7.0]
  def up
    create_table :providers do |t|
      t.string :name
      t.string :nit
      t.string :contact_name
      t.string :contact_phone
      t.timestamps
    end
  end

  def down
    drop_table :providers if table_exists? :providers
  end
end
