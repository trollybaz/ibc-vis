# TODO: Going to remove this, this just for development
class DebugLogger < Logger
  def format_message(severity, timestamp, progname, msg)
    "#{timestamp.to_formatted_s(:db)} #{severity} #{msg}\n"
  end
end


debug_logfile = File.open("log/debug.log", 'a')
debug_logfile.sync = true
DEBUG_LOG = DebugLogger.new(debug_logfile)
