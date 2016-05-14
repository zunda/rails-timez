# Monkey patch to tzinfo gem to look inside, based upon
# tzinfo-1.2.2/lib/tzinfo/timezone_offset.rb

module TZInfo
  class TimezoneOffset
    alias :initialize_orig :initialize
    def initialize(utc_offset, std_offset, abbreviation)
      initialize_orig(utc_offset, std_offset, abbreviation)
      puts "#{self.class}.new"
      instance_variables.sort.each do |ivar|
        puts "  #{ivar} = #{instance_variable_get(ivar)}"
      end
    end

    alias :to_local_orig :to_local
    def to_local(utc)
      puts "#{self.class}##{__method__}(#{utc.inspect}) is called"
      to_local_orig(utc)
    end
  end
end
