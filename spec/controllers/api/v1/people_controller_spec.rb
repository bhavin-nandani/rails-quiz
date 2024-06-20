require 'rails_helper'

RSpec.describe Api::V1::PeopleController, type: :request do
  describe "GET #index json" do
    before do
      create_list(:person, 20)
    end

    context "when format is json" do
      it "returns a list of people" do
        get "/api/v1/people", headers: { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
        expect(response).to be_successful

        if response.status == 200
            json = JSON.parse(response.body)
            expect(json['people'].length).to eq(10)
            expect(json).to have_key('page')
            expect(json).to have_key('per_page')
            expect(json).to have_key('total_pages')
            expect(json).to have_key('total_count')
        end
      end

      it "filters people by email" do
        create(:person, email: "specific.email@example.com")
        get "/api/v1/people", params: { email: "specific.email@example.com" }, headers: { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }

        expect(response).to be_successful
        json = JSON.parse(response.body)
        expect(json['people'].length).to eq(1)
        expect(json['people'][0]['email']).to eq("specific.email@example.com")
      end
    end
  end
end
