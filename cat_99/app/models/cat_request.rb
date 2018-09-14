# == Schema Information
#
# Table name: cat_requests
#
#  id         :bigint(8)        not null, primary key
#  cat_id     :integer          not null
#  user_id    :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRequest < ApplicationRecord



end
