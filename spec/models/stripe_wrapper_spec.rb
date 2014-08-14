require 'spec_helper'

describe StripeWrapper::Charge do
  before do
    StripeWrapper.set_api_key
  end

  let(:token) do
    Stripe::Token.create(
      :card => {
        number: card_number,
        exp_month: 8,
        exp_year: 2018,
        cvc: 123
      }
    ).id
  end

  context "with valid card" do
    let(:card_number) { '4242424242424242' }
    let(:response){
      StripeWrapper::Charge.create(amount: 300, card: token)
    }
    it "charges the card successfully", :vcr do
       response.should be_successful
     end
  end

  context "with invalid card" do
    let(:card_number) { '4000000000000002' }
    let(:response){
      StripeWrapper::Charge.create(amount: 300, card: token)
    }

    it "does not charge the card successfully", :vcr do
      response.should_not be_successful
    end

    it "contains an error message", :vcr do
      response.error_message.should == 'Your card was declined.'
    end
  end
end
