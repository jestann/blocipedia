class CollaborationPolicy
  attr_reader :user, :collaboration

  def initialize(user, collaboration)
    @user = user
    @collaboration = collaboration
  end

  def index?
    user && (user == collaboration.wiki.user || collaboration.wiki.collaborators.include?(user) || user.admin?)
  end

  def show?
    user && (user == collaboration.wiki.user || collaboration.wiki.collaborators.include?(user) || user.admin?)
  end

  def create?
    user && ((user.premium? && user == collaboration.wiki.user && collaboration.wiki.private? ) || user.admin?)
  end

  def new?
    create?
  end

  # there is no update / edit method at present, so this is for future use.
  # users can update their own collaboration
  def update?
    user && (user == collaboration.user || user == collaboration.wiki.user || user.admin?)
  end
  
  def edit?
    update?
  end

  # users can only destroy their own collaboration
  def destroy?
    user && (user == collaboration.user || user == collaboration.wiki.user || user.admin?)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
