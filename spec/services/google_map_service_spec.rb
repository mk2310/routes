require 'rails_helper'

RSpec.describe GoogleMapService do
  let(:params) do
    {
      begin_lat: '0',
      begin_long: '0',
      end_lat: '1',
      end_long: '1'
    }
  end

  let(:request_params) do
    {
      origin: [params[:begin_lat], params[:begin_long]].join(','),
      destination: [params[:end_lat], params[:end_long]].join(','),
      language: 'ru',
      mode: 'DRIVING',
      alternatives: true,
      key: Rails.configuration.api_key
    }
  end

  let(:response_data) do
    {
      "routes": [
        {
          "legs": [
            {
              "distance": {
                "text": "7,9 мил."
              },
              "duration": {
                "text": "26 мин."
              }
            }
          ]
        },
        {
          "legs": [
            {
              "distance": {
                "text": "16,7 мил."
              },
              "duration": {
                "text": "29 мин."
              }
            }
          ]
        }
      ],
      "status": "OK"
    }.with_indifferent_access
  end

  let(:extracted_data) do
    [
      {
        distance: "7,9 мил.",
        time: "26 мин."
      },
      {
        distance: "16,7 мил.",
        time: "29 мин."
      }
    ]
  end

  describe '#request_params' do
    it 'should return params' do
      described_class_params = described_class.new(params).request_params
      expect(described_class_params).to eql(request_params)
    end
  end

  # describe '#get_data' do
  #   it 'should return response from' do
  #     # described_class.new(params)
  #   end
  # end

  describe '#extract_data' do
    it 'should distance and time' do
      data = described_class.new(params).extract_data(response_data)
      expect(data).to eql(extracted_data)
    end
  end

  describe '#perform' do
  end

  describe '#' do
  end
  describe '#' do
  end
end
