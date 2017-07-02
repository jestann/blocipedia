require 'rails_helper'
require 'pundit_matcher'

describe WikiPolicy do
  subject { WikiPolicy.new(user, wiki) }

  context "a visitor and a public wiki" do
    let(:user) { nil }
    let(:wiki) { create(:wiki) }

    it { should permit(:index)   }
    it { should permit(:show)    }

    it { should_not permit(:create)  }
    it { should_not permit(:new)     }
    it { should_not permit(:update)  }
    it { should_not permit(:edit)    }
    it { should_not permit(:destroy) }
  end

  context "a user who doesn't own a public wiki" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:wiki) { create(:wiki, user: other_user) }

    it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should permit(:update)  }
    it { should permit(:edit)    }
    it { should_not permit(:destroy) }
  end
  
  context "a user who does own a public wiki" do
    let(:user) { create(:user) }
    let(:wiki) { create(:wiki, user: user) }
      
    it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should permit(:update)  }
    it { should permit(:edit)    }
    it { should permit(:destroy) }
  end
  
  context "an admin who doesn't own a public wiki" do
    let(:user) { create(:user, role: :admin) }
    let(:other_user) { create(:user) }
    let(:wiki) { create(:wiki, user: other_user) }
      
    it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should permit(:update)  }
    it { should permit(:edit)    }
    it { should permit(:destroy) }
  end
  
  context "a visitor and a private wiki" do
    let(:user) { nil }
    let(:wiki) { create(:wiki, private: true) }
    
    it { should_not permit(:show)    }
    it { should_not permit(:create)  }
    it { should_not permit(:new)     }
    it { should_not permit(:update)  }
    it { should_not permit(:edit)    }
    it { should_not permit(:destroy) }
  end
  
  context "a standard user and a private wiki" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, user: other_user, private: true) }
    
    it { should_not permit(:show)    }
    it { should_not permit(:create)  }
    it { should_not permit(:new)     }
    it { should_not permit(:update)  }
    it { should_not permit(:edit)    }
    it { should_not permit(:destroy) }
  end
  
  context "premium user who doesn't own a private wiki" do
    let(:user) { create(:user, role: :premium) }
    let(:other_user) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, user: other_user, private: true) }
    
    it { should_not permit(:show)    }
    it { should_not permit(:create)  }
    it { should_not permit(:new)     }
    it { should_not permit(:update)  }
    it { should_not permit(:edit)    }
    it { should_not permit(:destroy) }
  end
  
  context "premium user who does own a private wiki" do
    let(:user) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, user: user, private: true) }
    
    it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should permit(:update)  }
    it { should permit(:edit)    }
    it { should permit(:destroy) }
  end
  
  context "premium user who does own a private wiki" do
    let(:user) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, user: user, private: true) }
    
    it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should permit(:update)  }
    it { should permit(:edit)    }
    it { should permit(:destroy) }
  end
  
  context "admin user who doesn't own a private wiki" do
    let(:user) { create(:user, role: :admin) }
    let(:other_user) { create(:user, role: :premium) }
    let(:wiki) { create(:wiki, user: other_user, private: true) }
    
    it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should permit(:update)  }
    it { should permit(:edit)    }
    it { should permit(:destroy) }
  end
  
end