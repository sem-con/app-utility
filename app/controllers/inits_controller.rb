class InitsController < ApplicationController
	include ApplicationHelper

	def create
		case params[:button]
		when "reset"
			redirect_to container_definition_path(sidebar: (params[:sidebar] || "expand"))
		when "create"
			@ic = InitCreate.new(
				key_id: SecureRandom.uuid,
				title: params[:title].to_s,
				description: params[:description].to_s,
				creator_type: params[:creator_type].to_s,
				creator_name: params[:creator_name].to_s,
				creator_email: params[:creator_email].to_s,
				contributor_name: params[:contributor_name].to_s,
				contributor_email: params[:contributor_email].to_s,
				usage_policy: params[:usage_policy].to_s,
				data_format: params[:data_format].to_s,
				data_model: params[:data_model].to_s,
				data_constraints: params[:data_constraints].to_s,
				data_example: params[:data_example].to_s)
			@ic.save
			redirect_to container_definition_path(init: @ic.key_id, sidebar: (params[:sidebar] || "expand"))
		when "validate"
			# init_trig = params[:init_trig].to_s
			# # image_constraints = params[:image_constraints].to_s

			# init = RDF::Reader.for(:trig).new(params[:image_constraints].to_s)
			# image_constraints = RDF::Repository.load("./config/image-constraints.trig", format: :trig)

			base_config = RDF::Reader.for(:trig).new(params[:init_trig].to_s)
			image_constraints = RDF::Reader.for(:trig).new(params[:image_constraints].to_s)

            init_validation = {
                "base-config": base_config.dump(:trig).to_s,
                "image-constraints": image_constraints.dump(:trig).to_s
            }.stringify_keys

            puts "init_validation======"
            puts init_validation.to_json
            puts "====================="

            # fix me!!! should parse image_constraints and use value in :BaseConfiguration > :initValidationService
			init_validation_url = "https://semantic.ownyourdata.eu/api/validate/init"

            response = HTTParty.post(init_validation_url, 
                headers: { 'Content-Type' => 'application/json' },
                body: init_validation.to_json)
            puts "Response: " + response.to_s

			@ic = InitCreate.new(
				key_id: SecureRandom.uuid,
				title: params[:title].to_s,
				description: params[:description].to_s,
				creator_type: params[:creator_type].to_s,
				creator_name: params[:creator_name].to_s,
				creator_email: params[:creator_email].to_s,
				contributor_name: params[:contributor_name].to_s,
				contributor_email: params[:contributor_email].to_s,
				usage_policy: params[:usage_policy].to_s,
				data_format: params[:data_format].to_s,
				data_model: params[:data_model].to_s,
				data_constraints: params[:data_constraints].to_s,
				data_example: params[:data_example].to_s,
				init_trig: params[:init_trig].to_s,
				image_constraints: params[:image_constraints].to_s,
				validation_url: params[:validation_url].to_s,
				validation: (response.code == 200) )
			@ic.save

			redirect_to container_definition_path(init: @ic.key_id, valid: (response.code == 200).to_s, sidebar: (params[:sidebar] || "expand"))
		else	
			redirect_to container_definition_path(sidebar: (params[:sidebar] || "expand"))
		end
	end
end