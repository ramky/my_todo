require 'spec_helper'

feature "Visitor makes payment", { vcr: true, js: true } do
  background  do
    visit new_payment_path
  end

  scenario "valid card number", driver: :selenium do
    pay_with_credit_card('4242424242424242')
    page.should have_content 'Thank you for your generous support'
  end

  scenario "invalid card number" do
    pay_with_credit_card('4000000000000069')
    page.should have_content 'Your card has expired'
  end

  scenario "declined card" do
    pay_with_credit_card('4000000000000002')
    page.should have_content 'Your card was declined'
  end
end

def pay_with_credit_card(card_number)
  fill_in 'Credit Card Number', with: card_number
  fill_in 'Security Code', with: '123'
  select '3 - March', from: 'date_month'
  select '2017', from: 'date_year'
  click_button 'Submit Payment'
end
