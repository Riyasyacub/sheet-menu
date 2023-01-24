class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :by_created, -> { order(created_at: :asc) }

  def self.most_recently_created
    by_created.last
  end

  def self.earliest_created
    by_created.first
  end

end
