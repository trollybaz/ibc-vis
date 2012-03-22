class EventType < ActiveRecord::Base
  has_many :event_type_members, dependent: :destroy

  attr_accessible :name, :frequency
end
