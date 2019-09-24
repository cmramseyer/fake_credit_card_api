class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :credit_card_id
      t.float :amount_before
      t.float :payment_amount
      t.float :current_amount

      t.timestamps
    end
  end
end
