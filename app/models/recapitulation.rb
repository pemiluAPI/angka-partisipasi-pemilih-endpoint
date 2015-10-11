class Recapitulation < ActiveRecord::Base
	belongs_to	:category
	belongs_to	:subdistrict
	has_many	:dpts

	def build_dpt
		dpts = Array.new

		self.dpts.each do |dpt|
			dpts << {
				name: dpt.name,
				value: dpt.value
			}
		end

		return dpts
	end
end
