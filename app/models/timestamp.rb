class Timestamp < ActiveRecord::Base
	include ApplicationHelper
	attr_reader :obj

	@@format = "%Y-%m-%d %H:%M:%S %:z"

	def evaluate!(str)
		@str = str
		@obj = eval(str)
	end

	def to_s
		"#{@obj.strftime(@@format)} <- #{@str}\t(#{@obj.class})"
	end

	def Timestamp.evaluate(str)
		ts = Timestamp.new
		ts.evaluate!(str)
		return ts
	end

	def Timestamp.system_zone
		return Time.now.zone
	end

	def Timestamp.rails_zone
		return Time.zone.name
	end
end
