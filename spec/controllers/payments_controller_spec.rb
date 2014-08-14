require 'spec_helper'

describe PaymentsController do
  describe "POST create" do
    context "with a successful charge" do
      before do
        charge = double('charge')
        charge.stub(:successful?).and_return(true)
        StripeWrapper::Charge.stub(:create).and_return(charge)

        post :create, token: '123'
      end

      it "sets the flash success message" do
        flash[:success].should == 'Thank you for your generous support.'
      end
      it "redirects to the new payment path" do
        response.should redirect_to new_payment_path
      end
    end

    context "with a failed charge" do
      before  do
        charge = double('charge')
        charge.stub(:successful?).and_return(false)
        charge.stub(:error_message).and_return('Your card was declined.')
        StripeWrapper::Charge.stub(:create).and_return(charge)

        post :create, token: '123'
      end

      it "sets the flash error message" do
        flash[:error].should == 'Your card was declined.'
      end

      it "redirects to the payments path" do
        response.should redirect_to new_payment_path
      end
    end
  end
end
