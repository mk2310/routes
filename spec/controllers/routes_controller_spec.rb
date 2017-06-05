require 'rails_helper'

RSpec.describe ::V1::RoutesController, type: :controller do
  describe '#new' do
    let(:params) do
      {
        begin_lat: '40.8171321',
        begin_long: '-73.99449150000001',
        end_lat: '40.7416627',
        end_long: '-74.0728354'
      }
    end

    it 'should return data' do
      # raise params
      get :new, params: params
      expect(response.body).to eql({ routes: 'routes' }.to_json)
    end
  end
end
