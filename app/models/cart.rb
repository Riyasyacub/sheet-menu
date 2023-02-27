class Cart < ApplicationRecord
  belongs_to :hotel, class_name: "User", foreign_key: :hotel_id
  belongs_to :table
  has_many :orderables, dependent: :destroy
  has_many :menu_items, through: :orderables

  default_scope -> { order('created_at desc') }

  scope :billed, -> { where(billed: true) }
  scope :not_billed, -> { where(billed: false) }
  scope :today, -> { where("created_at < '#{Date.tomorrow}' and created_at >= '#{Date.today}'")}

  validate :can_be_billed?

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
    orderables.where(ordered: true, cancelled: false)
  end

  def ordered_with_cancelled_items
    orderables.where(ordered: true)
  end

  def served_items
    orderables.where(ordered: true, served: true)
  end

  def cancelled_items
    orderables.where(ordered: true, cancelled: true)
  end

  def pending_items
    orderables.where(ordered: true, served: false, cancelled: false)
  end

  private

  def items_scope(scope)
    case scope
    when :items
      self.items
    when :ordered_items
      self.ordered_items
    when :pending_items
      self.pending_items
    end
  end

  def can_be_billed?
    return if orderables.where(ordered: true, cancelled: false).all? { |a| a.served?  }
    errors.add(:base, "There are some pending items in the cart!")
  end
end
