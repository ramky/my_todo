class PaymentsController < ApplicationController
  def create
    Stripe.api_key = ENV['STRIPE_API_KEY']

    token = params[:stripeToken]

    begin
      charge = Stripe::Charge.create(
        :amount => 3000, # amount in cents, again
        :currency => "usd",
        :card => token,
        :description => 'thank you for your donation to todo app'
      )
      flash[:success] = 'Thank you for your generous support.'
      redirect_to new_payment_path
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_payment_path
    end
  end
end
