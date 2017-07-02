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
    let(:other_user) { create(:user) }
    let(:wiki) { create(:wiki, user: other_user) }

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
    let(:other_user) { create(:user) }
    let(:wiki) { create(:wiki, user: other_user) }
      
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
  
  context "a standard user and a private wiki" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, user: other_user, private: true) }
    
    it { should_not authorize(:show)    }
    it { should_not authorize(:create)  }
    # it { should_not authorize(:new)   } # does not make sense when used without a specific wiki instance
    it { should_not authorize(:update)  }
    it { should_not authorize(:edit)    }
    it { should_not authorize(:destroy) }
  end
  
  context "premium user who doesn't own a private wiki" do
    let(:user) { create(:user, role: :premium) }
    let(:other_user) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, user: other_user, private: true) }
    
    it { should_not authorize(:show)    }
    # it { should_not authorize(:create)} # does not make sense in this context
    # it { should_not authorize(:new)   } # does not make sense in this context
    it { should_not authorize(:update)  }
    it { should_not authorize(:edit)    }
    it { should_not authorize(:destroy) }
  end
  
  context "premium user who does own a private wiki" do
    let(:user) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, user: user, private: true) }
    
    it { should authorize(:show)    }
    it { should authorize(:create)  }
    it { should authorize(:new)     }
    it { should authorize(:update)  }
    it { should authorize(:edit)    }
    it { should authorize(:destroy) }
  end
  
  context "premium user who does own a private wiki" do
    let(:user) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, user: user, private: true) }
    
    it { should authorize(:show)    }
    it { should authorize(:create)  }
    it { should authorize(:new)     }
    it { should authorize(:update)  }
    it { should authorize(:edit)    }
    it { should authorize(:destroy) }
  end
  
  context "admin user who doesn't own a private wiki" do
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