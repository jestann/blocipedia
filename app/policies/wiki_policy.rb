# I finally gave up inheriting from application policy ... because I thought using "record" was less readable
# and I was just making it all from scratch anyway. And there are only wikis, no other resource.

# Questions:
# Why not @user and @wiki?

class WikiPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end
  
  def index?
    true
  end

  def show?
    wiki.private? ? ( (user.try(:premium?) && user == wiki.user) || user.try(:admin?) ) : true
  end

  def create?
    user
    # original value:
    # user && ( wiki.private? ? (user.premium? || user.admin?) : true )
    # don't test for allowance of creating a private wiki in this policy... test in permitted attributes or disallow in view?
  end
  
  # didn't originally match #create?. Rewrote #new? to just query 'user' as this method is used
  # for displaying the #new button in the index view where a class instance is passed 
  # as the parameter and there is no wiki.private value to test
  def new?
    user
  end

  def update?
    user && ( wiki.private? ? ( (user.premium? && user == wiki.user) || user.admin? ) : true )
  end
  
  def edit?
    update?
  end

  def destroy?
    user && (user == wiki.user || user.admin?)
  end

  # only premium users and admins can create a private wiki
  def permitted_attributes_for_create
    if (user.admin? || user.premium?)
      [:title, :body, :private]
    elsif (user)
      [:title, :body]
    else
      []
    end
  end
  
  # only owners and admins can edit a wiki's title
  # only premium owners and admins can edit a wiki's privacy
  def permitted_attributes_for_update
    if (user.admin? || (user.premium? && user == wiki.user))
      [:title, :body, :private]
    elsif (user == wiki.user)
      [:title, :body]
    elsif (user)
      [:body]
    else
      []
    end
  end
  
  # for displaying title edit functionality in view
  def permitted_for_title?
    destroy?
  end
  
  # for displaying private wiki selection in #new view
  def permitted_to_create_private_wiki?
    user && (user.premium? || user.admin?)
  end
  
  # for displaying private wiki selection in #edit view
  def permitted_to_update_private_wiki?
    user && ((user.premium? && user == wiki.user) || user.admin?)
  end
  
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user && user.admin?
        scope.all
      elsif user && user.premium?
        scope.where(private: false)
        # should be the below but won't work
        # scope.where('user = ? OR private = ?', @user, false)
      else
        scope.where(private: false)
      end
    end
  end
  
end
