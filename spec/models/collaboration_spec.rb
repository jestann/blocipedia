require 'rails_helper'

RSpec.describe Collaboration, type: :model do
  let(:user) { create(:user) }
  let(:wiki) { create(:wiki, private: true) }
  let(:collaboration) { Collaboration.create!(wiki: wiki, user: user) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:wiki) }

  it { is_expected.to validate_presence_of(:wiki) }
  it { is_expected.to validate_presence_of(:user) }
  
  describe "attributes" do
    it "has user, wiki attributes" do
        expect(collaboration).to have_attributes(wiki: wiki, user: user)
    end
    
  # test in the controller        
  # it "can only belong to a private wiki" do
  #   expect(collaboration.wiki.private).to eq true
  # end
  end

end
