require 'rails_helper'

RSpec.describe CollaborationsController, type: :controller do

  let(:user) { create(:user, role: :premium) }
  let(:collaborator) { create(:user) }
  let(:wiki) { create(:wiki, user: user) }

  # let policies take care of contexts
  describe 'POST create' do
    it 'redirects to the wiki show view' do
      post :create, { wiki: wiki, user: collaborator }
      expect(response).to redirect_to wiki
    end
    
    it 'creates a collaboration for current wiki and correct user' do
      expect(Collaboration.where(wiki: wiki, user: collaborator).first).to be_nil
      post :create, { wiki: wiki, user: collaborator }
      expect(Collaboration.where(wiki: wiki, user: collaborator).first).not_to be_nil
    end
  end

  describe 'DELETE destroy' do
    let(:collaboration) { create(:collaboration, wiki: wiki, user: collaborator) }

    it 'redirects to the wiki show view' do
      delete :destroy, id: collaboration.id
      expect(response).to redirect_to wiki
    end
      
    it 'destroys the collaboration for the user and wiki' do
      expect(Collaboration.where(wiki: wiki, user: collaborator).first).not_to be_nil
      delete :destroy, id: collaboration.id
      expect(Collaboration.where(wiki: wiki, user: collaborator).first).to be_nil
    end
  end

end