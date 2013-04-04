class Material < ActiveRecord::Base

  include SearchSortPaginate

  THUMBNAIL_WIDTH  = 271
  THUMBNAIL_HEIGHT = 211

  has_attached_file :thumbnail, :path => 'applications/material/thumbnails/:id/:filename'
  has_attached_file :document,  :path => 'applications/material/documents/:id/:filename'

  validates_attachment :thumbnail, :presence => true, :content_type => { :content_type => /^image\/(png|gif|jpeg)/ }
  validates_attachment :document,  :presence => true, :content_type => { :content_type => /^application\/(msword|vnd\.ms-excel|vnd\.ms-powerpoint|pdf)/ }

  validates :name, :presence => true, :uniqueness => true

  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    case parent_model.class.name.underscore
    when 'foo'
    else
      [
        { :name => :search, :as => :string, :fields => [:name], :wildcard => :both },
        { :name => :created_at, :as => :datetimerange },
      ]
    end
  end

end
