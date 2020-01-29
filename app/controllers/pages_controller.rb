class PagesController < ApplicationController
	include ApplicationHelper

	def index

	end

	def container_definition
		@init_create = "\n\n\n\n\n"
		@validation_url = "https://semantic.ownyourdata.eu/api/validate/init"
		@image_constraints = File.read("config/image-constraints.trig").to_s
		@usage_policy = File.read("data/usage_policy-default.trig").to_s
		@data_format_select = "none"
		if params[:init].to_s != ""
			@ic = InitCreate.find_by_key_id(params[:init].to_s)
			if !@ic.nil?
				@title = @ic.title.to_s
				@description = @ic.description.to_s
				@creator_type = @ic.creator_type.to_s || "none"
				@creator_name = @ic.creator_name.to_s
				@creator_email = @ic.creator_email.to_s
				operator_string = ""
				case @creator_type
				when "person"
					operator_string  = "dc:creator [\n"
					operator_string += "      rdf:type foaf:Person ;\n"
					operator_string += '      foaf:name "' + @creator_name + '" ;' + "\n"
					operator_string += "      foaf:mbox <mailto:" + @creator_email + "> ;\n"
					operator_string += "    ] ;"
				when "org"
					operator_string  = "dc:creator [\n"
					operator_string += "      rdf:type foaf:Organisation ;\n"
					operator_string += '      foaf:name "' + @creator_name + '" ;' + "\n"
					operator_string += "      foaf:mbox <mailto:" + @creator_email + "> ;\n"
					operator_string += "    ] ;"
				end
				@usage_policy = @ic.usage_policy.to_s
				@data_format_select = @ic.data_format.to_s
				if params[:valid].to_s == ""
					init_trig = File.read("config/init_template.trig")
					init_trig = init_trig.gsub("%%title%%", @title)
					init_trig = init_trig.gsub("%%description%%", @description)
					init_trig = init_trig.gsub("%%operator%%", operator_string)
					init_trig = init_trig.gsub("%%creator_name%%", @creator_name)
					init_trig = init_trig.gsub("%%creator_email%%", @creator_email)
					init_trig = add_defintion(init_trig, @usage_policy)
					init_trig = init_trig.gsub("%%usage_policy%%", get_body(@usage_policy))
					case @data_format_select
					when "csv"
						init_trig = init_trig.gsub("%%data_format%%", ":hasNativeSyntax <http://w3id.org/semcon/ns/ontology#CSV> ;")
					when "json"
						init_trig = init_trig.gsub("%%data_format%%", ":hasNativeSyntax <http://w3id.org/semcon/ns/ontology#JSON> ;")
					when "turtle"
						init_trig = init_trig.gsub("%%data_format%%", ":hasNativeSyntax w3c-format:Turtle ;")
					else
						init_trig = init_trig.gsub("%%data_format%%", "")
					end					
					init_trig = init_trig.gsub("%%data_model%%", @ic.data_model.to_s)
					init_trig = init_trig.gsub("%%data_constraints%%", @ic.data_constraints.to_s)
					init_trig = init_trig.gsub("%%data_example%%", @ic.data_example.to_s)
					@init_create = init_trig
					if @ic.validation_url.to_s != ""
						@validation_url = @ic.validation_url.to_s
					end
					if @ic.image_constraints.to_s != ""
						@image_constraints = @ic.image_constraints.to_s
					end
				else
					@init_create = @ic.init_trig
					@validation_url = @ic.validation_url.to_s
					@image_constraints = @ic.image_constraints
				end
			end
		end
	end

	def usage_policy
		@usage_policy = "\n\n\n\n\n"
		@usage_data_subject = "\n\n\n\n\n"
		@usage_data_controller = "\n\n\n\n\n"
		@mode = ""
		@data_list = {
			t('usage.data.Activity') => "Activity",
			t('usage.data.Anonymized') => "Anonymized",
			t('usage.data.AudiovisualActivity') => "AudiovisualActivity",
			t('usage.data.Computer') => "Computer",
			t('usage.data.Content') => "Content",
			t('usage.data.Demographic') => "Demographic",
			t('usage.data.Derived') => "Derived",
			t('usage.data.EarthObservation.label') => "EarthObservation",
			("&nbsp;" * 4 + t('usage.data.EarthObservation.Meteorology')).html_safe => "sc_custom_Meteorology",
			("&nbsp;" * 8 + t('usage.data.EarthObservation.MeteorologicMeasurement')).html_safe => "sc_custom_MeteorologicMeasurement",
			("&nbsp;" * 8 + t('usage.data.EarthObservation.MeteorologicForecast')).html_safe => "sc_custom_MeteorologicForecast",
			("&nbsp;" * 8 + t('usage.data.EarthObservation.MeteorologicCurrent')).html_safe => "sc_custom_MeteorologicCurrent",
			("&nbsp;" * 8 + t('usage.data.EarthObservation.MeteorologicHistoric')).html_safe => "sc_custom_MeteorologicHistoric",
			("&nbsp;" * 8 + t('usage.data.EarthObservation.MeteorologicRaster')).html_safe => "sc_custom_MeteorologicRaster",
			("&nbsp;" * 4 + t('usage.data.EarthObservation.Geophysics')).html_safe => "sc_custom_Geophysics",
			("&nbsp;" * 8 + t('usage.data.EarthObservation.GeophysicsSeismology')).html_safe => "sc_custom_GeophysicsSeismology",
			("&nbsp;" * 8 + t('usage.data.EarthObservation.GeophysicsMagneticField')).html_safe => "sc_custom_GeophysicsMagneticField",
			("&nbsp;" * 8 + t('usage.data.EarthObservation.GeophysicsGravimetry')).html_safe => "sc_custom_GeophysicsGravimetry",
			t('usage.data.Financial') => "Financial",
			t('usage.data.Government') => "Government",
			t('usage.data.Health') => "Health",
			("&nbsp;" * 4 + t('usage.data.HealthData.Diabetes')).html_safe => "sc_custom_Diabetes",
			("&nbsp;" * 8 + t('usage.data.HealthData.DiabetesSensor')).html_safe => "sc_custom_Sensor",
			("&nbsp;" * 8 + t('usage.data.HealthData.DiabetesInsulinPump')).html_safe => "sc_custom_InsulinPump",
			t('usage.data.Interactive') => "Interactive",
			t('usage.data.Judicial') => "Judicial",
			t('usage.data.Location') => "Location",
			t('usage.data.Navigation') => "Navigation",
			t('usage.data.Online') => "Online",
			t('usage.data.OnlineActivity') => "OnlineActivity",
			t('usage.data.Physical') => "Physical",
			t('usage.data.PhysicalActivity') => "PhysicalActivity",
			t('usage.data.Political') => "Political",
			t('usage.data.Preference') => "Preference",
			t('usage.data.Profile') => "Profile",
			t('usage.data.Purchase') => "Purchase",
			t('usage.data.Social') => "Social",
			t('usage.data.State') => "State",
			t('usage.data.Statistical') => "Statistical",
			t('usage.data.TelecomActivity') => "TelecomActivity",
			t('usage.data.UniqueId') => "UniqueId"
		}
		@purpose_list = {
			t('usage.purpose.Account') => 'Account',
			t('usage.purpose.Admin') => 'Admin',
			t('usage.purpose.Arts') => 'Arts',
			t('usage.purpose.Browsing') => 'Browsing',
			t('usage.purpose.Charity') => 'Charity',
			t('usage.purpose.Communicate') => 'Communicate',
			t('usage.purpose.Current') => 'Current',
			t('usage.purpose.Custom') => 'Custom',
			t('usage.purpose.Delivery') => 'Delivery',
			t('usage.purpose.Develop') => 'Develop',
			t('usage.purpose.Downloads') => 'Downloads',
			t('usage.purpose.Education') => 'Education',
			t('usage.purpose.Feedback') => 'Feedback',
			t('usage.purpose.Finmgt') => 'Finmgt',
			t('usage.purpose.Gambling') => 'Gambling',
			t('usage.purpose.Gaming') => 'Gaming',
			t('usage.purpose.Government') => 'Government',
			t('usage.purpose.Health') => 'Health',
			t('usage.purpose.Historical') => 'Historical',
			t('usage.purpose.Login') => 'Login',
			t('usage.purpose.Marketing') => 'Marketing',
			t('usage.purpose.MeteorologicalService') => 'MeteorologicalService',
			t('usage.purpose.News') => 'News',
			t('usage.purpose.Payment') => 'Payment',
			t('usage.purpose.Sales') => 'Sales',
			t('usage.purpose.Search') => 'Search',
			t('usage.purpose.State') => 'State',
			t('usage.purpose.Tailoring') => 'Tailoring',
			t('usage.purpose.Telemarketing') => 'Telemarketing',			
		} 

		if params[:usage].to_s != ""
			@usage = UsageCreate.find_by_key_id(params[:usage].to_s)
			if !@usage.nil? and params[:valid].to_s == ""
				@data_select = JSON.parse(@usage.data_category).reject(&:blank?)
				@recipient_select = JSON.parse(@usage.recipient).reject(&:blank?)
				@purpose_select = JSON.parse(@usage.purpose).reject(&:blank?)
				@processing_select = JSON.parse(@usage.processing).reject(&:blank?)
				@storage_location_select = JSON.parse(@usage.storage_location).reject(&:blank?)
				@storage_duration_select = @usage.storage_duration.to_s

				# Usage Policy begin
				@usage_policy = "@prefix owl: <http://www.w3.org/2002/07/owl#> .\n"
				@usage_policy += "@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\n"
				@usage_policy += "@prefix spl: <http://www.specialprivacy.eu/langs/usage-policy#> .\n"
				@usage_policy += "@prefix svd: <http://www.specialprivacy.eu/vocabs/data#> .\n"
				@usage_policy += "@prefix svr: <http://www.specialprivacy.eu/vocabs/recipients#> .\n"
				@usage_policy += "@prefix svpu: <http://www.specialprivacy.eu/vocabs/purposes#> .\n"
				@usage_policy += "@prefix svpr: <http://www.specialprivacy.eu/vocabs/processing#> .\n"
				@usage_policy += "@prefix svl: <http://www.specialprivacy.eu/vocabs/locations#> .\n"
				@usage_policy += "@prefix svdu: <http://www.specialprivacy.eu/vocabs/duration#> .\n"
				@usage_policy += "@prefix svd: <http://www.specialprivacy.eu/vocabs/data#> .\n"
				@usage_policy += "@prefix scp: <http://w3id.org/semcon/ns/policy#> .\n\n"
				@usage_policy += ":ContainerPolicy rdf:type owl:Class ; # this line should not be changed!\n"
				@usage_policy += "    owl:equivalentClass [ \n"
				@usage_policy += "        owl:intersectionOf ( \n"

				# Data Category
				@usage_policy += "            [ \n"
				@usage_policy += "                rdf:type owl:Restriction ;\n"
				@usage_policy += "                owl:onProperty spl:hasData ;\n"
				@usage_policy += "                owl:someValuesFrom "
				if @data_select.count == 0
					@usage_policy += "spl:AnyData\n"
				else
					@usage_policy += "[ \n"
					@usage_policy += "                    owl:unionOf ( \n"
					@data_select.each do |el|
						if el.start_with?("sc_custom_")
							@usage_policy += "                        scp:" + el.to_s[10..-1] + "\n"
						else
							@usage_policy += "                        svd:" + el.to_s + "\n"
						end
					end
					@usage_policy += "                    ) ;\n"
					@usage_policy += "                ] \n"
				end
				@usage_policy += "            ]\n"

				# Recipient
				@usage_policy += "            [ \n"
				@usage_policy += "                rdf:type owl:Restriction ;\n"
				@usage_policy += "                owl:onProperty spl:hasRecipient ;\n"
				@usage_policy += "                owl:someValuesFrom "
				if @recipient_select.count == 0
					@usage_policy += "spl:AnyRecipient\n"
				else
					@usage_policy += "[ \n"
					@usage_policy += "                    owl:unionOf ( \n"
					@recipient_select.each do |el|
						if el.start_with?("sc_custom_")
							@usage_policy += "                        scp:" + el.to_s[10..-1] + "\n"
						else
							@usage_policy += "                        svr:" + el.to_s + "\n"
						end
					end
					@usage_policy += "                    ) ;\n"
					@usage_policy += "                ] \n"
				end
				@usage_policy += "            ]\n"

				# Purpose
				@usage_policy += "            [ \n"
				@usage_policy += "                rdf:type owl:Restriction ;\n"
				@usage_policy += "                owl:onProperty spl:hasPurpose ;\n"
				@usage_policy += "                owl:someValuesFrom "
				if @purpose_select.count == 0
					@usage_policy += "spl:AnyPurpose\n"
				else
					@usage_policy += "[ \n"
					@usage_policy += "                    owl:unionOf ( \n"
					@purpose_select.each do |el|
						if el.start_with?("sc_custom_")
							@usage_policy += "                        scp:" + el.to_s[10..-1] + "\n"
						else
							@usage_policy += "                        svpu:" + el.to_s + "\n"
						end
					end
					@usage_policy += "                    ) ;\n"
					@usage_policy += "                ] \n"
				end
				@usage_policy += "            ]\n"

				# Processing
				@usage_policy += "            [ \n"
				@usage_policy += "                rdf:type owl:Restriction ;\n"
				@usage_policy += "                owl:onProperty spl:hasProcessing ;\n"
				@usage_policy += "                owl:someValuesFrom "
				if @processing_select.count == 0
					@usage_policy += "spl:AnyProcessing\n"
				else
					@usage_policy += "[ \n"
					@usage_policy += "                    owl:unionOf ( \n"
					@processing_select.each do |el|
						if el.start_with?("sc_custom_")
							@usage_policy += "                        scp:" + el.to_s[10..-1] + "\n"
						else
							@usage_policy += "                        svpr:" + el.to_s + "\n"
						end
					end
					@usage_policy += "                    ) ;\n"
					@usage_policy += "                ] \n"
				end
				@usage_policy += "            ]\n"

				# Storage
				@usage_policy += "            [ \n"
				@usage_policy += "                rdf:type owl:Restriction ;\n"
				@usage_policy += "                owl:onProperty spl:hasStorage ;\n"
				@usage_policy += "                owl:someValuesFrom [ \n"
				@usage_policy += "                    owl:intersectionOf ( \n"

				# Storage Location
				@usage_policy += "                        [ \n"
				@usage_policy += "                            rdf:type owl:Restriction ;\n"
				@usage_policy += "                            owl:onProperty spl:hasLocation ;\n"
				@usage_policy += "                            owl:someValuesFrom "
				if @storage_location_select.count == 0
					@usage_policy += "spl:AnyLocation\n"
				else
					@usage_policy += "[ \n"
					@usage_policy += "                                owl:unionOf ( \n"
					@storage_location_select.each do |el|
						if el.start_with?("sc_custom_")
							@usage_policy += "                        scp:" + el.to_s[10..-1] + "\n"
						else
							@usage_policy += "                        svl:" + el.to_s + "\n"
						end
					end
					@usage_policy += "                                ) ;\n"
					@usage_policy += "                            ] \n"
				end
				@usage_policy += "                        ] \n"

				# Storage Duration
				@usage_policy += "                        [ \n"
				@usage_policy += "                            rdf:type owl:Restriction ;\n"
				@usage_policy += "                            owl:onProperty spl:hasDuration ;\n"
				@usage_policy += "                            owl:someValuesFrom "
				if @storage_duration_select.length == 0
					@usage_policy += "spl:AnyDuration\n"
				else
					@usage_policy += "svdu:" + @storage_duration_select.to_s + "\n"
				end
				@usage_policy += "                        ] \n"
				@usage_policy += "                    ) \n"
				@usage_policy += "                ] \n "
				@usage_policy += "           ]\n"

				# Usage Policy end
				@usage_policy += "        ) ;\n"
				@usage_policy += "        rdf:type owl:Class\n"
				@usage_policy += "    ] .\n"
			elsif !@usage.nil? and params[:valid].to_s !=""
				@data_select = JSON.parse(@usage.data_category).reject(&:blank?)
				@recipient_select = JSON.parse(@usage.recipient).reject(&:blank?)
				@purpose_select = JSON.parse(@usage.purpose).reject(&:blank?)
				@processing_select = JSON.parse(@usage.processing).reject(&:blank?)
				@storage_location_select = JSON.parse(@usage.storage_location).reject(&:blank?)
				@storage_duration_select = @usage.storage_duration.to_s

				# Usage Policy begin
				@usage_policy = @usage.usage_policy

			end
		elsif params[:match].to_s != ""
			@mode = "match"
			@usage = UsageMatch.find_by_key_id(params[:match].to_s)
			if !@usage.nil?
				@usage_data_subject = @usage.data_subject
				@usage_data_controller = @usage.data_controller
				@match_valid = @usage.match_valid
			end

		elsif params[:mode].to_s != ""
			@mode = "match"
		end
	end

	def data_format
		@data_format_input_data = "\n\n\n\n\n"
		@data_format_constraints = "\n\n\n\n\n"
		if params[:data].to_s != ""
			@df = DataFormat.find_by_key_id(params[:data].to_s)
			if !@df.nil?
				@data_format_input_data = @df.input_data.to_s
				@data_format_constraints = @df.data_constraints.to_s
				@data_valid = @df.validation
			end
		end
	end

	def favicon
		send_file 'public/favicon.ico', type: 'image/x-icon', disposition: 'inline'
	end
end