class SponsorUser < ActiveRecord::Base
  belongs_to :sponsor
  belongs_to :user

  has_attached_file :eps_logo
  has_attached_file :logo

  validates_attachment :eps_logo, :presence => true, :content_type => { :content_type => /image\/(jpg|jpeg|png)/ }, :on => :update
  validates_attachment :logo,     :presence => true, :content_type => { :content_type => /image\/(jpg|jpeg|png)/ }, :on => :update

  def logos_uploaded?
    eps_logo.present? && logo.present?
  end

end
