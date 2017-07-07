class ChargesController < ApplicationController
  
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium - #{current_user.name}",
      amount: Amount.cost,
      amount_string: Amount.cost_string
    }
  end

  def create
    # Creates a Stripe customer to associate with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
   
    # Creates a Stripe charge
    Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.cost,
      description: "Blocipedia Premium - #{current_user.name}",
      currency: 'usd'
    )
    
    current_user.premium!
    
    flash[:notice] = "You're now signed up for Blocipedia Premium, #{current_user.name}!"
    redirect_to edit_user_registration_path
   
    # Rescue and display Stripe errors
    rescue Stripe::CardError => error
      flash[:alert] = error.message
      redirect_to new_charge_path
  end
  
  def downgrade
    # No refund to downgrade
    
    current_user.standard!
    current_user.wikis.update_all(private: false)

    flash[:notice] = "You have been downgraded to the free plan, #{current_user.name}."
    redirect_to edit_user_registration_path
  end
  
  private
  class Amount
    
    # Blocipedia Premium upgrade cost in pennies
    def self.cost
      15_00
    end
    
    # Blocipedia Premium upgrade cost in a pretty string
    def self.cost_string
      '$15'
    end
    
  end
  
end
