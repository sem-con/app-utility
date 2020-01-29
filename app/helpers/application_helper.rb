module ApplicationHelper

    def get_body(doc)
        retVal = ""
        doc.split("\n").each do |line|
            if !line.start_with?("@prefix")
                retVal += line + "\n"
            end
        end
        retVal
    end

    def get_definition(doc)
        retVal = ""
        doc.split("\n").each do |line|
            if line.start_with?("@prefix")
                retVal += line + "\n"
            end
        end
        retVal
    end

    def add_defintion(source, doc)
        definition = get_definition(doc)
        source_array = source.split("\n")
        pos = source_array.length - source_array.reverse.index{|line| line.start_with?("@prefix") }
        retVal = source_array[0..(pos-1)].join("\n")
        retVal += "\n" + definition
        retVal += source_array[pos..source_array.length].join("\n")
    end

    def validate(ds, dc)
        # build usage matching trig
        intro  = "@prefix sc: <http://w3id.org/semcon/ns/ontology#> .\n"
        intro += "@prefix owl: <http://www.w3.org/2002/07/owl#> .\n"
        intro += "@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\n"
        intro += "@prefix xml: <http://www.w3.org/XML/1998/namespace> .\n"
        intro += "@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n"
        intro += "@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .\n"
        intro += "@prefix spl: <http://www.specialprivacy.eu/langs/usage-policy#> .\n"
        intro += "@prefix svd: <http://www.specialprivacy.eu/vocabs/data#> .\n"
        intro += "@prefix svr: <http://www.specialprivacy.eu/vocabs/recipients#> .\n"
        intro += "@prefix svpu: <http://www.specialprivacy.eu/vocabs/purposes#> .\n"
        intro += "@prefix svpr: <http://www.specialprivacy.eu/vocabs/processing#> .\n"
        intro += "@prefix svl: <http://www.specialprivacy.eu/vocabs/locations#> .\n"
        intro += "@prefix svdu: <http://www.specialprivacy.eu/vocabs/duration#> .\n"
        intro += "@prefix svd: <http://www.specialprivacy.eu/vocabs/data#> .\n"
        intro += "@prefix scp: <http://w3id.org/semcon/ns/policy#> ."

        data_subject = get_body(ds).strip
        data_controller = get_body(dc).strip

        dataSubject_intro = "sc:DataSubjectPolicy rdf:type owl:Class ;\n"
        data_subject = data_subject.split("\n")[1..-1].join("\n")

        dataController_intro = "sc:DataControllerPolicy rdf:type owl:Class ;\n"
        data_controller = data_controller.split("\n")[1..-1].join("\n")

        up = intro + dataSubject_intro + data_subject + "\n" + dataController_intro + data_controller
        up = up.gsub("\r", "")
        up = up.gsub("\\u003c", "<")
        up = up.gsub("\\u003e", ">")

        usage_matching = {
            "usage-policy": up
        }.stringify_keys

        # query service if policies match
        usage_matching_url = "https://semantic.ownyourdata.eu/api/validate/usage-policy"
        response = HTTParty.post(usage_matching_url, 
            headers: { 'Content-Type' => 'application/json' },
            body: usage_matching.to_json)

        response
    end
end
