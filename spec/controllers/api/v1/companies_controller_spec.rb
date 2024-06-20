require 'rails_helper'

RSpec.describe "Api::V1::Companies", type: :request do
  describe "GET #index" do
    before do
      create_list(:company, 20)
    end

    context "when format is json" do
      it "returns a list of companies" do
        get '/api/v1/companies', headers: { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
        expect(response).to be_successful
        json = JSON.parse(response.body)
        expect(json['companies'].length).to eq(10) # Default per page in Kaminari
        expect(json).to have_key('page')
        expect(json).to have_key('per_page')
        expect(json).to have_key('total_pages')
        expect(json).to have_key('total_count')
      end

      it "filters companies by name" do
        create(:company, name: "Specific Company")
        get '/api/v1/companies', params: { name: "Specific" }, headers: { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
        expect(response).to be_successful
        json = JSON.parse(response.body)
        expect(json['companies'].length).to eq(1)
        expect(json['companies'][0]['name']).to eq("Specific Company")
      end
    end
  end

  describe "POST #create" do
    let(:valid_attributes) do
      {
        companies: [
          { name: "Company One" },
          { name: "Company Two" }
        ]
      }.to_json
    end

    let(:invalid_attributes) do
      {
        companies: [
          { name: "" },
          { name: nil }
        ]
      }.to_json
    end

    context "with valid attributes" do
      it "creates new companies" do
        expect {
          post '/api/v1/companies', params: valid_attributes, headers: { 'Authorization' => ActionController::HttpAuthentication::Basic.encode_credentials('username', 'password'), "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
        }.to change(Company, :count).by(2)
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json.length).to eq(2)
        expect(json[0]['name']).to eq("Company One")
        expect(json[1]['name']).to eq("Company Two")
      end
    end

    context "with invalid attributes" do
      it "does not create new companies" do
        expect {
          post '/api/v1/companies', params: invalid_attributes, headers: { 'Authorization' => ActionController::HttpAuthentication::Basic.encode_credentials('username', 'password'), "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
        }.not_to change(Company, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "without authentication" do
      it "returns unauthorized status" do
        post '/api/v1/companies', params: valid_attributes, headers: { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
