class SponsorUser < ActiveRecord::Base
  belongs_to :sponsor
  belongs_to :user

  has_attached_file :eps_logo
  has_attached_file :logo

  validates_attachment :eps_logo, :presence => true, :content_type => { :content_type => /image\/(jpg|jpeg|png)/ }, :on => :update
  validates_attachment :logo,     :presence => true, :content_type => { :content_type => /image\/(jpg|jpeg|png)/ }, :on => :update

  before_save :check_primary

  private
    def check_primary
      if self.primary_contact == true
        SponsorUser.where(sponsor_id: self.sponsor_id, primary_contact: true).update_all(primary_contact: false)
        self.primary_contact = true
      end
    end
end
