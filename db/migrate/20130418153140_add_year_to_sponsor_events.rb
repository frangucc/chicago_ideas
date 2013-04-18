class AddYearToSponsorEvents < ActiveRecord::Migration

  YEAR_2013 = 2013

  def change
    change_table :sponsor_events do |t|
      t.references :year
    end

    SponsorEvent.all.each do |se|
      se.update_attributes(:year => Year.find_by_id(YEAR_2013))
    end
  end

end
