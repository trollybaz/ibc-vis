class Event < ActiveRecord::Base
  belongs_to :event_type
  has_many :event_type_members, through: :event_type
end
