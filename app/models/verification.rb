class Verification < ActiveRecord::Base

	before_create :generate_code

	protected

	def generate_code
		self.code = rand(9999).to_s.center(4, rand(9).to_s)
	end
end
