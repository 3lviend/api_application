require 'rails_helper'
require 'faker'

RSpec.describe Api::V1::CustomersController, type: :controller do
  # test API customer list (index page) without secret token
  describe "GET #index without secret-token" do
    before do
      get :index
    end

    it "returns http 401" do
      expect(response).to have_http_status(401)
    end

    it "JSON body response contains expected customer attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.has_key?("message"))
      expect(json_response["message"].to_s.include?('unauthorized'))
    end
  end

  # test API customer list (index page) with secret token
  describe "GET #index with secret-token" do
    before do
      request.headers['secret-token'] = Rails.application.secrets.secret_token
      get :index
    end

    it "returns http 200" do
      expect(response).to have_http_status(200)
    end

    it "JSON body response contains expected customer attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.has_key?("customers"))

      # check keys if customers not zero
      unless json_response["customers"].count.zero?
        expect(json_response["customers"][0].keys).to match_array(['id', 'name', 'address_details'])
      end
    end
  end

  # test API Create customer with new address
  describe "POST #create customer with new address" do
    before do
      request.headers['secret-token'] = Rails.application.secrets.secret_token
      params = { customer:
                  {name: 'Elvin', address_attributes: {
                    street: Faker::Address.street_name, city: Faker::Address.city, zip_code: Faker::Address.zip_code}
                  }
                }

      post :create, params: params
    end

    it "returns http 200" do
      expect(response).to have_http_status(200)
    end

    it "JSON body response contains expected customer attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.has_key?("customer"))
      expect(json_response["customer"].keys).to match_array(['id', 'name', 'address_details'])
      expect(json_response["customer"]['name']).to match('Elvin')
    end
  end

  # test API Create customer with existing address
  describe "POST #create customer with existing address" do
    before do
      request.headers['secret-token'] = Rails.application.secrets.secret_token
      post :create, params: {customer: {name: 'Elvin', address_id: 1}}
    end

    it "returns http 200" do
      expect(response).to have_http_status(200)
    end

    it "JSON body response contains expected customer attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.has_key?("customer"))
      expect(json_response["customer"].keys).to match_array(['id', 'name', 'address_details'])
      expect(json_response["customer"]['name']).to match('Elvin')
    end
  end

  # test API Create customer with empty params
  describe "POST #create customer no params" do
    before do
      request.headers['secret-token'] = Rails.application.secrets.secret_token

      post :create, params: {}
    end

    it "returns http 433" do
      expect(response).to have_http_status(422)
    end

    it "JSON body response contains expected customer attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.has_key?("message"))
      expect(json_response["message"].to_s.downcase.include?("param is missing"))
    end
  end

  # test API Delete customer with existing customer id
  describe "DELETE #delete customer" do
    before do
      request.headers['secret-token'] = Rails.application.secrets.secret_token
      delete :destroy, params: {id: Customer.last.id}
    end

    it "returns http 204" do
      expect(response).to have_http_status(204)
    end
  end

  # test API Delete customer with customer not registered in database
  describe "DELETE #delete not registered customer" do
    before do
      request.headers['secret-token'] = Rails.application.secrets.secret_token
      delete :destroy, params: {id: 99}
    end

    it "returns http 204" do
      expect(response).to have_http_status(404)
    end

    it "JSON body response contains expected error messages" do
      json_response = JSON.parse(response.body)
      expect(json_response.has_key?("message"))
      expect(json_response["message"].to_s.downcase.include?("not found"))
    end
  end

end
