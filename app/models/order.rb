class Order < ApplicationRecord
  belongs_to :user
  belongs_to :order_status
  has_many :order_items, dependent: :destroy
  before_save :update_subtotal

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def checkout
    self[:order_status_id] = 2
    save!
  end
  private
  def update_subtotal
    self[:subtotal] = subtotal
  end
end
