class Material < ActiveRecord::Base

  THUMBNAIL_WIDTH  = 271
  THUMBNAIL_HEIGHT = 211

  has_attached_file :thumbnail, :path => 'applications/material/thumbnails/:id/:filename'
  has_attached_file :document,  :path => 'applications/material/documents/:id/:filename'

  validates_attachment :thumbnail, :presence => true, :content_type => { :content_type => /^image\/(png|gif|jpeg)/ }
  validates_attachment :document,  :presence => true, :content_type => { :content_type => /^application\/(msword|vnd\.ms-excel|vnd\.ms-powerpoint|pdf)/ }

  validates :name, :presence => true, :uniqueness => true

end
