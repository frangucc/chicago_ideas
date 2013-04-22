class AddEpsLogoAndLogoToSponsorUser < ActiveRecord::Migration

  def up
    add_attachment :sponsor_users, :eps_logo
    add_attachment :sponsor_users, :logo
  end

  def down
    remove_attachment :sponsor_users, :eps_logo
    remove_attachment :sponsor_users, :logo
  end

end
