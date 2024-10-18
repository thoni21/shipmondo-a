class CreateAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts do |t|
      t.integer :balance

      t.timestamps
    end
  end
end
