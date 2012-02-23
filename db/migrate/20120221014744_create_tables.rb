class CreateTables < ActiveRecord::Migration
  def up
    # create family table
    create_table :families do |t|
      t.string :last_name
    end
    # create person table
    create_table :people do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.belongs_to :family
      t.string :description
    end

    # create event_types table    
    create_table :event_types do |t|
      t.string :name
      t.integer :frequency
    end

    # create event_type_member table
    create_table :event_type_members do |t|
      t.belongs_to :event_type
      t.belongs_to :person
    end

    create_table :events do |t|
      t.belongs_to :event_type
      t.date :date
    end

    # create attendances table (date, type, user_id)
    create_table :attendances do |t|
      t.belongs_to :event
      t.belongs_to :person
    end
  end

  def down
    drop_table :events
    drop_table :attendances
    drop_table :event_type_members
    drop_table :event_types
    drop_table :people
    drop_table :families
  end
end
