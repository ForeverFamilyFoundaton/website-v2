class Charge < ApplicationRecord
  belongs_to :user

  scope :sorted, ->{ order(created_at: :desc) }
  default_scope ->{ sorted }

  def filename
    "receipt-#{created_at.strftime("%Y-%m-%d")}.pdf"
  end

  def receipt
    Receipts::Receipt.new(
      id: id,
      product: "Yearly Membership",
      company: {
        name: "Forever Family Foundation",
        address: "222 Atlantic Avenue, Oceanside, New York 11572-2009",
        email: "@foreverfamilyfoundation.com"
      },
      line_items: line_items
    )
  end

  def line_items
    line_items = [
      ["Date", created_at.to_s],
      ["Account Billed", "#{user.name} (#{user.email})"],
      ["Product", "My Product"],
      ["Amount", ApplicationController.helpers.formatted_amount(amount)],
      ["Charged to", "#{card_brand} ending in #{card_last4}"],
    ]

    line_items << ["Amount Refunded", ApplicationController.helpers.formatted_amount(amount_refunded)] if amount_refunded?
    line_items
  end

  def refund(amount: nil)
    Stripe::Refund.create(charge: stripe_id, amount: amount)
    update(amount_refunded: amount)
  end
end
