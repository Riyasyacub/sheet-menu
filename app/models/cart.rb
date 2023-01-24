class Cart < ApplicationRecord
  belongs_to :hotel, class_name: "User", foreign_key: :hotel_id
  belongs_to :table
  has_many :orderables
  has_many :menu_items, through: :orderables

  default_scope -> { order('created_at desc') }

  scope :billed, -> { where(billed: true) }
  scope :not_billed, -> { where(billed: false) }

  def total(scope = :items)
    items = items_scope(scope)
    items.to_a.sum { |orderable| orderable.total }
  end

  def tax(scope = :items)
    items = items_scope(scope)
    items.to_a.sum { |orderable| orderable.tax }.round(2)
  end

  def served?
    orderables.pluck(:served).all?
  end

  def checkout
    self.items.update_all(ordered: true, ordered_at: Time.now)
  end

  def items
    orderables.where(ordered: false, served: false)
  end

  def ordered_items
    orderables.where(ordered: true)
  end

  def served_items
    orderables.where(ordered: true, served: true)
  end

  def cancelled_items
    orderables.where(ordered: true, cancelled: true)
  end

  def pending_items
    orderables.where(ordered: true, served: false)
  end

  private

  def items_scope(scope)
    case scope
    when :items
      self.items
    when :ordered
      self.ordered_items
    end
  end
end
