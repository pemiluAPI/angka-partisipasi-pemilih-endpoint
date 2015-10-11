class Category < ActiveRecord::Base
	has_many	:recapitulations
end
