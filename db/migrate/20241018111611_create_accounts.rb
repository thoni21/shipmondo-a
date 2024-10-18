class CreateAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts do |t|
      t.numeric :balance

      t.timestamps
    end
  end
end
