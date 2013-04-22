class RemoveSponsorAgreementFromSponsorUser < ActiveRecord::Migration

  def up
    remove_attachment :sponsor_users, :sponsor_agreement
  end

  def down
    add_attachment :sponsor_users, :sponsor_agreement
  end

end
