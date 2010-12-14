require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "Signing Up for an Account" do
  # cheap way to get around resetting the applications db
  let(:timestamp) { Time.now.to_i.to_s }

  def signup_free_user(login, email, password)
    visit "/"
    find(".signup-button").click

    fill_in 'Username',         :with => login
    fill_in 'Email Address',    :with => email
    fill_in 'Password',         :with => password
    fill_in 'Confirm Password', :with => password

    find("#signup_button").click
  end

  it "allows new users to signup for free accounts" do
    signup_free_user("me#{timestamp}",
                     "me+#{timestamp}@example.org",
                     "allofthelights999")

    find("h1").text.should eql("Hi, me#{timestamp}")
  end

  it "informs users that passwords must contain letters and numbers" do
    signup_free_user("me#{timestamp}",
                     "me+#{timestamp}@example.org",
                     "password")

    find(".form.error .error").text.should eql("Password needs at least one number.")
  end
end
