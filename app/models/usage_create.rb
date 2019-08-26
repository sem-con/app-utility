# == Schema Information
#
# Table name: usage_creates
#
#  id               :bigint(8)        not null, primary key
#  data_category    :text
#  processing       :string
#  purpose          :string
#  recipient        :string
#  storage_duration :string
#  storage_location :string
#  usage_policy     :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  key_id           :string
#

class UsageCreate < ApplicationRecord
end
