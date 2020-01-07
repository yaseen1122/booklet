class Bookleet < ApplicationRecord
	has_many :tbcs, dependent: :destroy
end
