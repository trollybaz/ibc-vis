class AttendancesController < ApplicationController
  def create
  end


  # GET /workspaces/id/events/id/attendances/
  # GET /workspaces/id/attendances/
  # TODO: Optimize this
  def index
    event = get_event
    date = event.date
    event_type = event.event_type


    # get all the people who attended

    # result = ActiveRecord::Base.connection.select_all( “SELECT * FROM authors_books WHERE 1″ )

    SELECT
      u.id, u.first_name, u.middle_name, u.last_name,
      u.description, ca.attended
    FROM event_types_members m, event_types t, users u
    LEFT JOIN (
      SELECT a.user_id, true as attended
      FROM events e, attendances a
      WHERE
        e.id = a.event_id AND
        e.id = ?
      ) as current_attendances ca
    ON m.user_id = ca.user_id
    WHERE
      m.user_id = u.id
      AND m.event_type_id = t.id
      AND t.id = ? 
      

    

  end

  private

  # if params has event id, use that event
  # otherwise:
  #  default to 'sunday_serivce event type'
  #  look up by date
  #
  # if lookup failed, create the event
  def get_event(date = nil)
    nil  
  end

  # if params has date, use that date
  # otherwise get the most recent sunday
  def get_date
    return Time.now
  end

  
end
