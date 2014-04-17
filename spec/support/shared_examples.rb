shared_examples "require_sign_in" do
  it "redirects user to the front page if they are not signed in" do
    clear_current_user
    action 
    response.should redirect_to front_page_path
  end
end
