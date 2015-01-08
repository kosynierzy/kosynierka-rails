require 'spec_helper'

describe Authorize do
  subject { described_class.new(id, info, options) }

  let(:info) do
    {
      email: email,
      username: username,
      roles: []
    }
  end
  let(:options) { {user_repo: user_repo} }
  let(:email) { 'test@example.com' }
  let(:username) { 'test' }
  let(:user_repo) { UserRepoMock }

  describe '#call' do
    let(:result) { subject.call }

    context 'when user is known' do
      let(:id) { 'user-1' }

      it 'returns updated user' do
        expect(result.id).to eq(id)
        expect(result.username).to eq(username)
        expect(result.email).to eq(email)
      end
    end

    context 'when user is not known' do
      let(:id) { 'user-0' }

      it 'returns new user' do
        expect(result.id).to eq(id)
        expect(result.username).to eq(username)
        expect(result.email).to eq(email)
      end
    end
  end

  class UserRepoMock
    def self.find_by(attrs)
      if attrs.fetch(:id) == 'user-1'
        UserMock.new(id: 'user-1', username: 'double', email: 'double@example.com')
      else
        nil
      end
    end

    def self.new(attrs)
      user = UserMock.new(attrs)
      yield user if block_given?
      user
    end
  end

  class UserMock
    attr_accessor :id, :email, :username, :roles

    def initialize(attrs)
      update_attributes!(attrs)
    end

    def update_attributes!(attrs)
      attrs.each do |k, v|
        send("#{k}=", v)
      end
    end

    def save!
    end
  end
end
