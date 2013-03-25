class ChangeBhsiApplicationsSexToString < ActiveRecord::Migration

  def change
    change_column :bhsi_applications, :gender, :string, :limit => 10
  end

end
