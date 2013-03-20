class RemoveLimitFromPhoneNumbersInBhsiApplications < ActiveRecord::Migration

  def change
    change_table :bhsi_applications do |t|
      t.change :phone_number,      :string
      t.change :reference_1_phone, :string
      t.change :reference_2_phone, :string
    end
  end

end
