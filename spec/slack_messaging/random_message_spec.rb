# frozen_string_literal: true

require 'spec_helper'
require 'slack_messaging'

describe SlackMessaging::RandomMessage do
  let(:quote_object) { double(:quote_object, body: quote_json) }

  let(:quote_json) do
    "{\"_id\":\"4MRaRRKq4Tcg\",
      \"tags\":[\"famous-quotes\"],
      \"content\":\"There are two ways of spreading light: to be the candle or the mirror that reflects it.\",
      \"author\":\"Edith Wharton\",\"length\":87
    }"
  end

  before do
    allow(HTTParty).to receive(:get).and_return(quote_object)
  end

  subject { SlackMessaging::RandomMessage }

  it 'should get a string message' do
    message = subject.acquire_random_quote
    expect(message).to be_instance_of(String)
  end

  it 'should get a message that includes a newline' do
    message = subject.acquire_random_quote
    expect(message.include?("\n")).to eq(true)
  end

  it 'should get a message that includes a —' do
    message = subject.acquire_random_quote
    expect(message.include?('—')).to eq(true)
  end

  it 'should use HTTParty to ping an API' do
    expect(HTTParty).to receive(:get)
    subject.acquire_random_quote
  end

  it 'should have the JSON parse the response content twice' do
    expect(JSON).to receive(:parse).at_least(2).times.and_return(JSON.parse(quote_json))
    subject.acquire_random_quote
  end
end
