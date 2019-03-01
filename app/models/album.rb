class Album < ApplicationRecord
    validates :band_name, :title, :year, presence: true
    
    belongs_to :band,
        foreign_key: :band_name

    has_many :tracks

end