class Task < ActiveRecord::Base
  attr_accessible :completed, :lastActivationDelay, :name, :activationDelay

  validates :name, :activationDelay, :presence => true

  scope :active, where('nextActivationDate <= (?) and completed = "f"', Time.now)

  def activationDelay=(value)
    self.lastActivationOffset = value
    self.nextActivationDate = Time.now.advance(days: value.to_i).beginning_of_day()
  end
  
  def activationDelay
    lastActivationOffset
  end
end
