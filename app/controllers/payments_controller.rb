class PaymentsController < ApplicationController
  def create
    token = params[:stripeToken]

    charge = StripeWrapper::Charge.create(
      :amount => 3000,
      :card => token,
    )
    if charge.successful?
      flash[:success] = 'Thank you for your generous support.'
      redirect_to new_payment_path
    else
      flash[:error] = charge.error_message
      redirect_to new_payment_path
    end
  end
end
