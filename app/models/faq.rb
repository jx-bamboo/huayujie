class Faq < ApplicationRecord
  validates :ask,:answer,presence: true
end
