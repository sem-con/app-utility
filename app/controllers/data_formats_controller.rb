class DataFormatsController < ApplicationController
	include ApplicationHelper

	def validate
		case params[:button]
		when "reset"
			redirect_to data_format_path(sidebar: (params[:sidebar] || "expand"))
		when "validate"
            data_validation = {
                "content-data": params[:input_data].to_s,
                "content-constraints": params[:data_constraints].to_s
            }.stringify_keys

			data_validation_url = "https://semantic.ownyourdata.eu/api/validate/data"
            response = HTTParty.post(data_validation_url, 
                headers: { 'Content-Type' => 'application/json' },
                body: data_validation.to_json)

			@df = DataFormat.new(
			key_id: SecureRandom.uuid,
			input_data: params[:input_data].to_s,
			data_constraints: params[:data_constraints].to_s,
			validation: (response.code == 200) )
			@df.save

			redirect_to data_format_path(data: @df.key_id, valid: (response.code == 200).to_s, sidebar: (params[:sidebar] || "expand"))

		else
			redirect_to data_format_path(sidebar: (params[:sidebar] || "expand"))
		end
	end
end