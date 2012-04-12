class EventTypeMember < ActiveRecord::Base
  belongs_to :event_type
  belongs_to :person

  attr_accessible :person_id, :event_type_id
end
