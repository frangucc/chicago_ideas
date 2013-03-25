class AddAuthnetFieldsToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :an_response_reason_text, :string
    add_column :orders, :an_authorization_code,   :string
    add_column :orders, :an_invoice_number,       :string
    add_column :orders, :an_account_number,       :string
    add_column :orders, :an_card_type,            :string

    Order.all.each do |o|
      o.an_response_reason_text  = o.authnet_response.fields[:response_reason_text]
      o.an_authorization_code    = o.authnet_response.fields[:authorization_code]
      o.an_invoice_number        = o.authnet_response.fields[:invoice_number]
      o.an_account_number        = o.authnet_response.fields[:account_number]
      o.an_card_type             = o.authnet_response.fields[:card_type]
      o.save
    end
  end

  def self.down
    remove_column :orders, :an_response_reason_text
    remove_column :orders, :an_authorization_code
    remove_column :orders, :an_invoice_number
    remove_column :orders, :an_account_number
    remove_column :orders, :an_card_type
  end
end
