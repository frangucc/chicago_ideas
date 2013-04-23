class RemoveSponsorAgreementSignedFromSponsorUser < ActiveRecord::Migration

  def up
    remove_column :sponsor_users, :sponsor_agreement_signed
  end

  def down
    add_column :sponsor_users, :sponsor_agreement_signed, :boolean, :default => false
  end

end
