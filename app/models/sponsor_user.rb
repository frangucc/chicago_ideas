class SponsorUser < ActiveRecord::Base
  belongs_to :sponsor
  belongs_to :user

  before_save :check_primary

  private
    def check_primary
      if self.primary_contact == true
        SponsorUser.where(sponsor_id: self.sponsor_id, primary_contact: true).update_all(primary_contact: false)
        self.primary_contact = true
      end
    end
end
