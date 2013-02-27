class AddGeneralBenefitsColumnToMemberTypes < ActiveRecord::Migration

  def up
    change_table :member_types do |t|
      t.text   :general_benefits
      t.rename :description, :specific_benefits
    end
  end

  def down
    change_table :member_types do |t|
      t.remove :general_benefits
      t.rename :specific_benefits, :description
    end
  end

end
