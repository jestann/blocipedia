require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }

  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:wiki) { create(:wiki, user: user) }


  context "guest user" do
    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #index view" do
        get :index
        expect(response).to render_template(:index)
      end
      
      it "assigns wiki to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq [wiki]
      end
    end
    
    describe "GET show" do
      it "returns http success" do
        get :show, id: wiki.id
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #show view" do
        get :show, id: wiki.id
        expect(response).to render_template :show
      end
      
      it "assigns wiki to @wiki" do
        get :show, id: wiki.id
        expect(assigns(:wiki)).to eq wiki
      end
    end
    
    describe "GET new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
    
    describe "POST create" do
      it "returns http redirect" do
        post :create, wiki: {title: title, body: body, user: user}
        expect(response).to redirect_to new_user_session_path
      end
    end
    
    describe "GET edit" do
      it "returns http redirect" do
        get :edit, id: wiki.id
        expect(response).to redirect_to new_user_session_path
      end
    end
    
    describe "PUT update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to new_user_session_path
      end
    end
    
    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, id: wiki.id
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
  
  
  
  context "ordinary user on a post they don't own" do
    before do
      sign_in other_user
    end
    
    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #index view" do
        get :index
        expect(response).to render_template(:index)
      end
      
      it "assigns wiki to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq [wiki]
      end
    end
    
    describe "GET show" do
      it "returns http success" do
        get :show, id: wiki.id
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #show view" do
        get :show, id: wiki.id
        expect(response).to render_template :show
      end
      
      it "assigns wiki to @wiki" do
        get :show, id: wiki.id
        expect(assigns(:wiki)).to eq wiki
      end
    end
    
    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end
      
      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end
    
    describe "POST create" do
      it "increases the number of wikis by one" do
        expect{post :create, wiki: {title: title, body: body}}.to change(Wiki, :count).by 1
      end
      
      it "assigns the new wiki to @wiki" do
        post :create, wiki: {title: title, body: body}
        expect(assigns(:wiki)).to eq Wiki.last
      end
      
      it "redirects to the new wiki" do
        post :create, wiki: {title: title, body: body}
        expect(response).to redirect_to Wiki.last
      end
    end
    
    describe "GET edit" do
      it "returns http success" do
        get :edit, id: wiki.id
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #edit view" do
        get :edit, id: wiki.id
        expect(response).to render_template :edit
      end
      
      it "assigns wiki to be updated to @wiki" do
        get :edit, id: wiki.id
        expect(assigns(:wiki)).to eq wiki
      end
    end
  
    describe "PUT update" do
      it "updates wiki body attribute" do
        new_body = RandomData.random_paragraph
        put :update, id: wiki.id, wiki: {body: new_body}
        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq wiki.id
        expect(updated_wiki.title).to eq wiki.title
        expect(updated_wiki.body).to eq new_body
      end
      
      it "doesn't allow update of wiki title attribute" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to wiki
      end  
      
      it "redirects to the updated wiki" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to wiki
      end
    end
    
    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, id: wiki.id
        expect(response).to have_http_status(:redirect)
      end
    end
  end
  
  
  
  context "ordinary user on a post they do own" do
    before do
      sign_in user
    end
    
    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #index view" do
        get :index
        expect(response).to render_template(:index)
      end
      
      it "assigns [wiki] to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq [wiki]
      end
    end
  
    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #new view" do
        get :new
        expect(response).to render_template(:new)
      end
      
      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end
    
    describe "GET show" do
      it "returns http success" do
        get :show, id: wiki.id
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #show view" do
        get :show, id: wiki.id
        expect(response).to render_template :show
      end
      
      it "assigns wiki to @wiki" do
        get :show, id: wiki.id
        expect(assigns(:wiki)).to eq wiki
      end
    end
    
    describe "POST create" do
      it "increases the number of wikis by one" do
        expect{post :create, wiki: {title: title, body: body}}.to change(Wiki, :count).by 1
      end
      
      it "assigns the new wiki to @wiki" do
        post :create, wiki: {title: title, body: body}
        expect(assigns(:wiki)).to eq Wiki.last
      end
      
      it "redirects to the new post" do
        post :create, wiki: {title: title, body: body}
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, id: wiki.id
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #edit view" do
        get :edit, id: wiki.id
        expect(response).to render_template :edit
      end
      
      it "assigns wiki to be updated to @wiki" do
        get :edit, id: wiki.id
        expect(assigns(:wiki)).to eq wiki
      end
    end
  
    describe "PUT update" do
      it "updates wiki with expected attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: wiki.id, wiki: {title: new_title, body: new_body}
        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end
      
      it "redirects to the updated wiki" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to wiki
      end
    end
    
    describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, id: wiki.id
        expect(Wiki.where({id: wiki.id}).length).to eq 0
      end
      
      it "redirects to #index" do
        delete :destroy, id: wiki.id
        expect(response).to redirect_to wikis_path
      end
    end
  end
  
  context "admin user on a post they don't own" do
    before do
      other_user.admin!
      sign_in other_user
    end
    
    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #index view" do
        get :index
        expect(response).to render_template(:index)
      end
      
      it "assigns [wiki] to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq [wiki]
      end
    end
  
    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #new view" do
        get :new
        expect(response).to render_template(:new)
      end
      
      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end
    
    describe "GET show" do
      it "returns http success" do
        get :show, id: wiki.id
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #show view" do
        get :show, id: wiki.id
        expect(response).to render_template :show
      end
      
      it "assigns wiki to @wiki" do
        get :show, id: wiki.id
        expect(assigns(:wiki)).to eq wiki
      end
    end
    
    describe "POST create" do
      it "increases the number of wikis by one" do
        expect{post :create, wiki: {title: title, body: body}}.to change(Wiki, :count).by 1
      end
      
      it "assigns the new wiki to @wiki" do
        post :create, wiki: {title: title, body: body}
        expect(assigns(:wiki)).to eq Wiki.last
      end
      
      it "redirects to the new post" do
        post :create, wiki: {title: title, body: body}
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, id: wiki.id
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #edit view" do
        get :edit, id: wiki.id
        expect(response).to render_template :edit
      end
      
      it "assigns wiki to be updated to @wiki" do
        get :edit, id: wiki.id
        expect(assigns(:wiki)).to eq wiki
      end
    end
  
    describe "PUT update" do
      it "updates wiki with expected attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: wiki.id, wiki: {title: new_title, body: new_body}
        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end
      
      it "redirects to the updated wiki" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, id: wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to wiki
      end
    end
    
    describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, id: wiki.id
        expect(Wiki.where({id: wiki.id}).length).to eq 0
      end
      
      it "redirects to #index" do
        delete :destroy, id: wiki.id
        expect(response).to redirect_to wikis_path
      end
    end
  end

end