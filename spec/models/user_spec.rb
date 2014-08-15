require 'rails_helper'

RSpec.describe User, type: :model do
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
end
