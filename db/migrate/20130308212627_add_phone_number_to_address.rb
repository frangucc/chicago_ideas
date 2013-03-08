class AddPhoneNumberToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :phone, :string, length: 20
  end
end
