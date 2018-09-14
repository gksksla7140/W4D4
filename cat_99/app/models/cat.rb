# == Schema Information
#
# Table name: cats
#
#  id          :bigint(8)        not null, primary key
#  color       :string           not null
#  name        :string           not null
#  brith_date  :date             not null
#  description :string           not null
#  sex         :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper

  CAT_COLOR = %w(red yellow blue brown)

  validates :color, inclusion: CAT_COLOR, unless: -> { color.blank? }
  validates :sex, inclusion: %w(M F), if: -> { sex }
  validate :birth_date_in_the_past, if: -> { birth_date }


  def age
  time_ago_in_words(birth_date)
  end

private

def birth_date_in_the_past
  if birth_date && birth_date > Time.now
    errors[:birth_date] << 'must be in the past'
  end
end



end
