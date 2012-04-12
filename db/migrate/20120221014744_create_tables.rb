class CreateTables < ActiveRecord::Migration
  def up
    # create family table
    create_table :families do |t|
      t.string :name
      t.datetime :created_at
      t.string :address
    end

    # create person table
    create_table :people do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date   :birthday
      t.integer :gender, default: 0, null: false, limit: 2
      t.belongs_to :family
      t.string :description
      t.integer :status, default: 0, null: false
      t.timestamps
    end

    # create event_types table, e.g. Sunday Morning Service
    create_table :event_types do |t|
      t.string :name, null: false
      t.integer :frequency
    end

    # create event_type_member table
    create_table :event_type_members do |t|
      t.belongs_to :event_type, null: false
      t.belongs_to :person, null: false
    end

    # a particular Sunday morning
    create_table :events do |t|
      t.belongs_to :event_type, null: false
      t.date :date, null: false
    end

    # create attendances table (date, type, user_id)
    # whether or not a person attended that Sunday
    create_table :attendances do |t|
      t.belongs_to :event, null: false
      t.belongs_to :person, null: false
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
