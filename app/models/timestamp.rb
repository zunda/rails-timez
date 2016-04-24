class Timestamp < ApplicationRecord
	include ApplicationHelper
	attr_reader :obj

	def evaluate!(str)
		@str = str
		@obj = eval(str)
	end

	def to_s
		"#{@str.inspect} became #{@obj.inspect}"
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
