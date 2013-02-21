class AddImageColumnToMemberTypes < ActiveRecord::Migration
  def change
    add_attachment :member_types, :image
  end
end
