# == Schema Information
#
# Table name: usage_matches
#
#  id              :bigint(8)        not null, primary key
#  data_controller :text
#  data_subject    :text
#  match_valid     :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  key_id          :string
#

class UsageMatch < ApplicationRecord
end
