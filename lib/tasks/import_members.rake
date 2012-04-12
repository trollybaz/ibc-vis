# rake import:members[filename]
# Instructions: copy and paste directory into a 'nix text file.  delete first few lines of file.

namespace :import do
  
  desc 'Download and setup a local Apache Solr installation'
  task :members, [:filename] => :environment do |t, args|
    filename = args[:filename]

    FamilyParser.import_members(filename)
  end

end
