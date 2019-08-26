# == Schema Information
#
# Table name: init_creates
#
#  id                :bigint(8)        not null, primary key
#  contributor_email :string
#  contributor_name  :string
#  creator_email     :string
#  creator_name      :string
#  creator_type      :string
#  data_constraints  :text
#  data_example      :text
#  data_format       :string
#  data_model        :text
#  description       :text
#  image_constraints :text
#  init_trig         :text
#  title             :string
#  usage_policy      :text
#  validation        :boolean
#  validation_url    :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  key_id            :string
#

class InitCreate < ApplicationRecord
end
