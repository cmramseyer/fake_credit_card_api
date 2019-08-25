class CreateCreditCards < ActiveRecord::Migration[6.0]
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.float :current_amount
      t.string :code
      t.integer :user_id
      t.string :user_name
      t.string :user_last_name

      t.timestamps
    end
  end
end
