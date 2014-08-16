require 'rails_helper'

RSpec.describe User, type: :model do
  def auth_stub
    {
      'provider' => 'github',
      'uid' => '1',
      'info' => {
        'nickname' => 'foo',
        'name' => 'Foo Bar',
        'image' => 'http://example.com/image.jpg',
      },
    }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:items).dependent(:restrict_with_exception) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_presence_of(:uid) }
    it {
      FactoryGirl.create(:user)
      is_expected.to validate_uniqueness_of(:uid)
        .scoped_to(:provider)
        .case_insensitive
    }
    it { is_expected.to validate_presence_of(:username) }
    it {
      is_expected.to ensure_length_of(:username)
        .is_at_least(1)
        .is_at_most(255)
    }
    it { is_expected.to validate_presence_of(:name) }
    it {
      is_expected.to ensure_length_of(:name)
        .is_at_least(2)
        .is_at_most(20)
    }
    it { is_expected.to validate_presence_of(:avatar_url) }
    it { is_expected.to ensure_length_of(:avatar_url).is_at_most(255) }
  end

  describe '.from_omniauth' do
    context 'user exists' do
      before do
        @auth = auth_stub

        # Creates user corresponds with the auth
        @user = FactoryGirl.create(
          :user,
          provider: @auth['provider'],
          uid: @auth['uid'],
          username: 'test',
          name: 'Test',
          avatar_url: 'http://example.com/test.jpg',
        )
      end

      it 'updates the user with values of auth' do
        # User receives update! call
        attrs = {
          username: 'foo',
          name: 'Foo Bar',
          avatar_url: 'http://example.com/image.jpg',
        }
        expect_any_instance_of(User).to receive(:update!).with(attrs)

        described_class.from_omniauth(auth_stub)
      end

      it 'returns an instance of User' do
        expect(described_class.from_omniauth(auth_stub)).to be_kind_of(User)
      end
    end

    context 'user does not exist' do
      it 'creates a new user' do
        expect {
          described_class.from_omniauth(auth_stub)
        }.to change(User, :count).by(1)
      end

      it 'returns an instance of User' do
        expect(described_class.from_omniauth(auth_stub)).to be_kind_of(User)
      end

      it 'returns a persisted object' do
        expect(described_class.from_omniauth(auth_stub)).to be_persisted
      end
    end
  end
end
