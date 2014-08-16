require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to ensure_length_of(:title).is_at_most(255) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to ensure_length_of(:url).is_at_most(255) }
  end
end
