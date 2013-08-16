require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "New", email: "name@email.com",
      password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "should require name" do
    before { @user.name = ""}
    it { should_not be_valid }
  end

  describe "should require email" do
    before { @user.email = ""}
    it { should_not be_valid }
  end

  describe "name should not be greater than 20 chars" do
    before { @user.name = "a" * 31 }
    it { should_not be_valid }
  end

  describe "email should be unique" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "password should be present" do
    before do
      @user = User.new(name: "New", email: "name@email.com",
        password: nil, password_confirmation: nil)
    end
    it { should_not be_valid }
  end

  describe "password should match confirmation" do
    before { @user.password_confirmation = "mismatch" }

    it { should_not be_valid }
  end

  describe "password should not be too short" do
    before do
      @user = User.new(name: "New", email: "name@email.com",
        password: "foob", password_confirmation: "foob")
    end
    it { should_not be_valid }
  end

  describe "should return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }
  
    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
end