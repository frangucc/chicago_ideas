class AddVentureStandardDeckToBhsiApplications < ActiveRecord::Migration

  def up
    add_attachment :bhsi_applications, :venture_standard_deck
  end

  def down
    remove_attachment :bhsi_applications, :venture_standard_deck
  end

end
