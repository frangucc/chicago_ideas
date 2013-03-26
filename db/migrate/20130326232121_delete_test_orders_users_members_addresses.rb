class DeleteTestOrdersUsersMembersAddresses < ActiveRecord::Migration
  def change
    if Rails.env.production?
      @orders = Order.where("id < 90")

      @orders.each do |o|
        user = o.try(:user)
        if user
          user.member.try(:delete)
          user.address.try(:delete)
          user.try(:delete)
        end
        o.billing_address.try(:delete)
        o.delete
      end
      puts "==== Deleted test orders ===="
    else
      puts "Nothing to do"
    end
  end
end
