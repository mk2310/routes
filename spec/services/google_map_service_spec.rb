require 'spec_helper'

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
                "text": "7,9"
              },
              "duration": {
                "text": "26"
              }
            }
          ]
        },
        {
          "legs": [
            {
              "distance": {
                "text": "16,7"
              },
              "duration": {
                "text": "29"
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
        distance: "7,9",
        time: "26"
      },
      {
        distance: "16,7",
        time: "29"
      }
    ]
  end

  describe '#request_params' do
    it 'should return params' do
      described_class_params = described_class.new(params).request_params
      expect(described_class_params).to eql(request_params)
    end
  end

  describe '#extract_data' do
    it 'should distance and time' do
      data = described_class.new(params).extract_data(response_data)
      expect(data).to eql(extracted_data)
    end
  end
end
