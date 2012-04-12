module FamilyParser
  # grammar:
  # FAMILYNAME
  # PEOPLE
  # ADDRESS
  # EMAIL
  # PHONE

  class State
    def process_line(state_context, line) 
      raise 'Subclasses need to implement this'
    end
  end
 
  class InitialState
    # transitions to PEOPLE
    def process_line(state_context, line) 
      if line =~ /^The\s*(.+)\s+Family$/
        family_name = $1
        state_context.family.name = family_name
      elsif line =~ /^(.+)\s+\(([^\)]+)\)$/
        name = $1
        # TODO: Use birthday when we are more confident
        # birthday = $2
        person = Person.new name: name # , birthday: birthday
        state_context.people << person

        person.set_name
        state_context.family.name = person.last_name
        person.family = state_context.family
      else
        raise "Invalid line: #{line}"
      end
      state_context.set_state(PeopleState.new)
    end
  end

  class PeopleState
    # stays PEOPLE
    # or moves to ADDRESS
    def process_line(state_context, line) 
      # Name SPACE (birthday)
      if line =~ /^(\D+)\s+\(([\d\/DOB]+)\)$/
        name = $1
        # TODO: Use birthday when we are more confident
        # birthday = $2
        person = Person.new name: name #, birthday: birthday
        state_context.people << person
        person.family = state_context.family
      # elsif ADDRESS
      else
      end
      # TODO: Transition to proer sate
      # state_context.set_state(PeopleState.new)
    end
  end

  class StateContext
    # people array
    # state

    attr_accessor :people, :family

    def initialize
      set_state(InitialState.new)
      @people = []
      @family = Family.new
    end

    # should only be called by the state
    def set_state(state)
      @state = state
    end

    def process(lines)
      lines.each do |line|
        process_line(line)
      end
    end

    def process_line(line)
      @state.process_line(self, line)
    end

  end

  def self.import_members(filename)
    File.open(filename, "r") do |infile|
      family_lines = []
      while (line = infile.gets)
        if line =~ /^\s*\*\s*$/
          process_family(family_lines)
          family_lines = []
        else
          family_lines << line.strip if line !~ /^\s*$/
        end
      end
    end

    # TODO: Put this somewhere that makes better sense
    # move them to the sunday list
    event_type = EventType.find_by_name('Sunday Morning Service')
    raise 'Could not find "Sunday Morning Service" event type!' if !event_type
    Person.where(status: 1).find_each do |person|
      member = EventTypeMember.new person_id: person.id, 
        event_type_id: event_type.id
      member.save!
    end
  end

  def self.process_family(family_lines)
    state_context = StateContext.new
    family_lines.each do |line|
      state_context.process_line(line)
    end
   
    # TODO: Move this logic to the proper place
    state_context.family.save!
    if state_context.people.size > 1
      count = 0
      while count < 2
        state_context.people[count].status = 1 # member
        count += 1
      end
      while count < state_context.people.size
        state_context.people[count].status = 5 # kid
        count += 1
      end
    end
    state_context.people.each do |person|
      person.save!
    end

  end



end
