require 'rails_helper'

describe CollaborationPolicy do
  subject { CollaborationPolicy.new(user, collaboration) }

  context "a visitor and a collaboration" do
    let(:user) { nil }
    let(:collaboration) { create(:collaboration) }

    it { should_not authorize(:index)   }
    it { should_not authorize(:show)    }
    it { should_not authorize(:create)  }
    it { should_not authorize(:new)     }
    it { should_not authorize(:update)  }
    it { should_not authorize(:edit)    }
    it { should_not authorize(:destroy) }
  end

  context "a standard user who owns a public wiki" do
    let(:user) { create(:user) }
    let(:owner) { create(:user) }
    let(:wiki) { create(:wiki, user: owner) }
    let(:collaboration) { create(:collaboration, wiki: wiki) }

    it { should_not authorize(:create)  }
    it { should_not authorize(:new)     }
    # other methods don't make sense in this context
  end
  
  context "a standard user who doesn't own or collaborate on a private wiki" do
    let(:user) { create(:user) }
    let(:owner) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, private: true, user: owner) }
    let(:collaboration) { create(:collaboration, wiki: wiki) }
    
    it { should_not authorize(:index)   }  
    it { should_not authorize(:show)    }
    it { should_not authorize(:create)  }
    it { should_not authorize(:new)     }
    it { should_not authorize(:update)  }
    it { should_not authorize(:edit)    }
    it { should_not authorize(:destroy) }
  end
  
  context "a standard user modifying self as a collaborator on a private wiki" do
    let(:user) { create(:user) }
    let(:owner) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, private: true, user: owner) }
    let(:collaboration) { create(:collaboration, wiki: wiki, user: user) }

    it { should authorize(:index)      }      
    it { should authorize(:show)       }
    it { should_not authorize(:create) }
    it { should_not authorize(:new)    }
    it { should authorize(:update)     }
    it { should authorize(:edit)       }
    it { should authorize(:destroy)    }
  end
  
  context "a premium user modifying others as collaborators on a private wiki they don't own" do
    let(:user) { create(:user, role: :premium) }
    let(:owner) { create(:user, role: :premium) }
    let(:collaborator) { create(:user) }

    let(:wiki) { create(:wiki, private: true, user: owner) }
    let(:collaboration) { create(:collaboration, wiki: wiki, user: collaborator) }

    it { should_not authorize(:index)      }      
    it { should_not authorize(:show)       }
    it { should_not authorize(:create) }
    it { should_not authorize(:new)    }
    it { should_not authorize(:update) }
    it { should_not authorize(:edit)       }
    it { should_not authorize(:destroy)    }
  end
 
  context "a premium user modifying self as a collaborator on a private wiki they don't own" do
    let(:user) { create(:user, role: :premium) }
    let(:owner) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, private: true, user: owner) }
    let(:collaboration) { create(:collaboration, wiki: wiki, user: user) }

    it { should authorize(:index)      }      
    it { should authorize(:show)       }
    it { should_not authorize(:create) }
    it { should_not authorize(:new)    }
    it { should authorize(:update)     }
    it { should authorize(:edit)       }
    it { should authorize(:destroy)    }
  end
  
  context "a premium user modifying others as collaborators on a private wiki they do own" do
    let(:user) { create(:user, role: :premium) }
    let(:collaborator) { create(:user) }
    let(:wiki) { create(:wiki, private: true, user: user) }
    let(:collaboration) { create(:collaboration, wiki: wiki, user: collaborator) }

    it { should authorize(:index)      }      
    it { should authorize(:show)       }
    it { should authorize(:create) }
    it { should authorize(:new)    }
    it { should authorize(:update)     }
    it { should authorize(:edit)       }
    it { should authorize(:destroy)    }
  end

  context "an admin user modifying others as collaborators on a private wiki they don't own" do
    let(:user) { create(:user, role: :admin) }
    let(:owner) { create(:user, role: :premium) }
    let(:collaborator) { create(:user) }
    let(:wiki) { create(:wiki, user: owner, private: true) }
    let(:collaboration) { create(:collaboration, wiki: wiki, user: collaborator) }
    
    it { should authorize(:index)   }
    it { should authorize(:show)    }
    it { should authorize(:create)  }
    it { should authorize(:new)     }
    it { should authorize(:update)  }
    it { should authorize(:edit)    }
    it { should authorize(:destroy) }
  end
  
end