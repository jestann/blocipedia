require 'rails_helper'

describe WikiPolicy do
  subject { WikiPolicy.new(user, wiki) }

  context "a visitor and a public wiki" do
    let(:user) { nil }
    let(:wiki) { create(:wiki) }

    it { should authorize(:index)   }
    it { should authorize(:show)    }

    it { should_not authorize(:create)  }
    it { should_not authorize(:new)     }
    it { should_not authorize(:update)  }
    it { should_not authorize(:edit)    }
    it { should_not authorize(:destroy) }
  end

  context "a user who doesn't own a public wiki" do
    let(:user) { create(:user) }
    let(:owner) { create(:user) }
    let(:wiki) { create(:wiki, user: owner) }

    it { should authorize(:show)    }
    it { should authorize(:create)  }
    it { should authorize(:new)     }
    it { should authorize(:update)  }
    it { should authorize(:edit)    }
    it { should_not authorize(:destroy) }
  end
  
  context "a user who does own a public wiki" do
    let(:user) { create(:user) }
    let(:wiki) { create(:wiki, user: user) }
      
    it { should authorize(:show)    }
    it { should authorize(:create)  }
    it { should authorize(:new)     }
    it { should authorize(:update)  }
    it { should authorize(:edit)    }
    it { should authorize(:destroy) }
  end
  
  context "an admin who doesn't own a public wiki" do
    let(:user) { create(:user, role: :admin) }
    let(:owner) { create(:user) }
    let(:wiki) { create(:wiki, user: user) }
      
    it { should authorize(:show)    }
    it { should authorize(:create)  }
    it { should authorize(:new)     }
    it { should authorize(:update)  }
    it { should authorize(:edit)    }
    it { should authorize(:destroy) }
  end
  
  context "a visitor and a private wiki" do
    let(:user) { nil }
    let(:wiki) { create(:wiki, private: true) }
    
    it { should_not authorize(:show)    }
    it { should_not authorize(:create)  }
    it { should_not authorize(:new)     }
    it { should_not authorize(:update)  }
    it { should_not authorize(:edit)    }
    it { should_not authorize(:destroy) }
  end
  
  context "a standard user who doesn't collaborate on a private wiki" do
    let(:user) { create(:user) }
    let(:owner) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, user: owner, private: true) }
    
    it { should_not authorize(:show)    }
    # it { should_not authorize(:create)} # this non-authorization is handled in permitted attributes and policy view methods
    # it { should_not authorize(:new)   } # does not make sense when used with a specific wiki instance
    it { should_not authorize(:update)  }
    it { should_not authorize(:edit)    }
    it { should_not authorize(:destroy) }
  end
  
  context "a standard user who does collaborate on a private wiki" do
    let(:user) { create(:user) }
    let(:owner) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, user: owner, private: true) }
    
    before do
      wiki.collaborations.create!(user: user)
    end
    
    it { should authorize(:show)        }
    # it { should_not authorize(:create)} # this non-authorization is handled in permitted attributes and policy view methods
    # it { should_not authorize(:new)   } # does not make sense when used with a specific wiki instance
    it { should authorize(:update)      }
    it { should authorize(:edit)        }
    it { should_not authorize(:destroy) }
  end
  
  context "a premium user who doesn't own or collaborate on a private wiki" do
    let(:user) { create(:user, role: :premium) }
    let(:owner) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, user: owner, private: true) }
    
    it { should_not authorize(:show)    }
    # it { should_not authorize(:create)} # does not make sense in this context
    # it { should_not authorize(:new)   } # does not make sense in this context
    it { should_not authorize(:update)  }
    it { should_not authorize(:edit)    }
    it { should_not authorize(:destroy) }
  end

  context "a premium user who doesn't own but does collaborate on a private wiki" do
    let(:user) { create(:user, role: :premium) }
    let(:owner) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, user: owner, private: true) }
    
    before do
      wiki.collaborations.create!(user: user)
    end
    
    it { should authorize(:show)        }
    # it { should_not authorize(:create)} # does not make sense in this context
    # it { should_not authorize(:new)   } # does not make sense in this context
    it { should authorize(:update)      }
    it { should authorize(:edit)        }
    it { should_not authorize(:destroy) }
  end

  context "premium user who owns a private wiki" do
    let(:user) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, user: user, private: true) }
    
    it { should authorize(:show)    }
    it { should authorize(:create)  }
    it { should authorize(:new)     }
    it { should authorize(:update)  }
    it { should authorize(:edit)    }
    it { should authorize(:destroy) }
  end
  
  context "admin user who doesn't own or collaborate on a private wiki" do
    let(:user) { create(:user, role: :admin) }
    let(:other_user) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, user: other_user, private: true) }
    
    it { should authorize(:show)    }
    it { should authorize(:create)  }
    it { should authorize(:new)     }
    it { should authorize(:update)  }
    it { should authorize(:edit)    }
    it { should authorize(:destroy) }
  end
  
end