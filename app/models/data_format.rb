# == Schema Information
#
# Table name: data_formats
#
#  id               :bigint(8)        not null, primary key
#  data_constraints :text
#  input_data       :text
#  validation       :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  key_id           :string
#

class DataFormat < ApplicationRecord
end
