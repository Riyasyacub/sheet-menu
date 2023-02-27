class Orderable < ApplicationRecord
  belongs_to :menu_item
  belongs_to :cart

  validate :can_cancel?

  def serve
    return if served?
    update(served: true, served_at: Time.now)
  end

  def cancel
    return if served? || preparing? || cancelled?
    update(cancelled: true)
  end

  def process
    return if served? || preparing?
    update(preparing: true)
  end

  def total
    menu_item.price * qty
  end

  def tax
    total * 0.05
  end

  private

  def can_cancel?
    return if !cancelled? || !preparing? || !served?
    errors.add(:base, "Cannot cancel a preparing order!")
  end
end
