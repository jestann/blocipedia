class CollaborationsController < ApplicationController

  def create
    @collaboration = Collaboration.new
    @collaboration.wiki = Wiki.find(params[:wiki_id])
    @collaboration.user = User.find(params[:collaboration][:user_id])

    if @collaboration.save
      flash[:notice] = "New collaborator was added."
    else
      flash[:alert] = "There was an error adding this collaborator. Please try again."
    end
    redirect_to @collaboration.wiki
  end
  
  def destroy
    wiki = Wiki.find(params[:wiki_id])
    @collaboration = wiki.collaborations.find(params[:id])
    
    if @collaboration.destroy
      flash[:notice] = 'Collaborator was removed.'
    else
      flash[:alert] = 'Error removing collaborator.'
    end
    redirect_to @collaboration.wiki
  end

end
