# spec/requests/companies_spec.rb

require 'rails_helper'

RSpec.describe "Companies", type: :request do
  let!(:company) { create(:company) }  # Creates a company using the factory

  describe "GET /index" do
    it "returns http success" do
      get companies_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get company_path(company)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get new_company_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get edit_company_path(company)
      expect(response).to have_http_status(:success)
    end
  end
end
