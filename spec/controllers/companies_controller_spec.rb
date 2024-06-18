# spec/controllers/companies_controller_spec.rb

require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  let(:valid_attributes) { { name: "Test Company" } }
  let(:invalid_attributes) { { name: "" } }
  let!(:company) { create(:company) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: company.id }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: company.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Company" do
        expect {
          post :create, params: { company: valid_attributes }
        }.to change(Company, :count).by(1)
      end

      it "redirects to the companies list" do
        post :create, params: { company: valid_attributes }
        expect(response).to redirect_to(companies_url)
      end
    end

    context "with invalid params" do
      it "returns an unprocessable entity status" do
        post :create, params: { company: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: "Updated Company" } }

      it "updates the requested company" do
        put :update, params: { id: company.id, company: new_attributes }
        company.reload
        expect(company.name).to eq("Updated Company")
      end

      it "redirects to the companies list" do
        put :update, params: { id: company.id, company: valid_attributes }
        expect(response).to redirect_to(companies_url)
      end
    end

    context "with invalid params" do
      it "returns an unprocessable entity status" do
        put :update, params: { id: company.id, company: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested company" do
      expect {
        delete :destroy, params: { id: company.id }
      }.to change(Company, :count).by(-1)
    end

    it "redirects to the companies list" do
      delete :destroy, params: { id: company.id }
      expect(response).to redirect_to(companies_url)
    end
  end
end
