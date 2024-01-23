class CreateBanks < ActiveRecord::Migration[7.0]
  def up
    create_table :banks do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :banks if table_exists? :banks
  end
end
