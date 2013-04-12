class PopulateSponsorEvents < ActiveRecord::Migration

  def change
    SponsorEvent.create!(:name  => 'Maximizing the CIW Sponsor Portal',
                         :month => 'July',
                         :day   => '10',
                         :info  => 'Info Session at Noon')
    SponsorEvent.create!(:name  => 'Maximizing the CIW Sponsor Portal',
                         :month => 'July',
                         :day   => '17',
                         :info  => 'Info Session at 5:00pm')
    SponsorEvent.create!(:name  => 'Ticketing Opens for Sponsors',
                         :month => 'July',
                         :day   => '29',
                         :info  => '')
    SponsorEvent.create!(:name  => 'Sponsors will receive invitations to all evening VIP receptions',
                         :month => 'Late',
                         :day   => 'July',
                         :info  => '')
    SponsorEvent.create!(:name  => 'Annual Sponsor Soiree',
                         :month => 'August',
                         :day   => '01',
                         :info  => '')
    SponsorEvent.create!(:name  => 'Ticketing Opens to CIW Members',
                         :month => 'August',
                         :day   => '12',
                         :info  => '')
    SponsorEvent.create!(:name  => 'Ticketing Opens to General Public',
                         :month => 'September',
                         :day   => '03',
                         :info  => '')
    SponsorEvent.create!(:name  => 'Menlo (VIP) Passes will be mailed to sponsors',
                         :month => 'Mid',
                         :day   => 'Sept',
                         :info  => '')
  end

end
