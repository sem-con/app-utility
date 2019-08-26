class UsagesController < ApplicationController
	include ApplicationHelper

	def create
		case params[:button]
		when "reset"
			redirect_to usage_policy_path(sidebar: (params[:sidebar] || "expand"))
		when "create"
			@usage = UsageCreate.new(
				key_id: SecureRandom.uuid,
				data_category: params[:data_category].to_s,
				recipient: params[:recipient].to_s,
				purpose: params[:purpose].to_s,
				processing: params[:processing].to_s,
				storage_location: params[:storage_location].to_s,
				storage_duration: params[:storage_duration].to_s)
			@usage.save

			redirect_to usage_policy_path(usage: @usage.key_id, sidebar: (params[:sidebar] || "expand"))
		when "validate"
			ds = File.read("data/usage_policy-unrestricted.trig")
			dc = params[:usage_policy].to_s
			response = validate(ds, dc)

			@usage = UsageCreate.new(
				key_id: SecureRandom.uuid,
				data_category: params[:data_category].to_s,
				recipient: params[:recipient].to_s,
				purpose: params[:purpose].to_s,
				processing: params[:processing].to_s,
				storage_location: params[:storage_location].to_s,
				storage_duration: params[:storage_duration].to_s,
				usage_policy: params[:usage_policy].to_s)
			@usage.save

			redirect_to usage_policy_path(usage: @usage.key_id, valid: (response.code == 200).to_s, sidebar: (params[:sidebar] || "expand"))
		else	
			redirect_to usage_policy_path(sidebar: (params[:sidebar] || "expand"))
		end
	end

	def match
		case params[:button]
		when "match"
			ds = params[:data_subject].to_s
			dc = params[:data_controller].to_s
			response = validate(ds, dc)

			@usage = UsageMatch.new(
				key_id: SecureRandom.uuid,
				data_subject: ds,
				data_controller: dc,
				match_valid: (response.code == 200))
			@usage.save
			redirect_to usage_policy_path(sidebar: (params[:sidebar] || "expand"), match: @usage.key_id, mode: "match")
		else
			redirect_to usage_policy_path(sidebar: (params[:sidebar] || "expand"), mode: "match")
		end
	end
end