require 'rails_helper'

RSpec.describe Uploads::FetchURLFromResourceKey, type: :service do
  it 'returns an absolute URL to our S3 bucket' do
    allow(ENV).to receive(:[]).with('COGNITO_ANON_UPLOAD_BUCKET').and_return('bucket')

    result = subject.perform('filename.jpg')

    expect(result).to eq('http://s3.amazonaws.com/bucket/filename.jpg')
  end
end
