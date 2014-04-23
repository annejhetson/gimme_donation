class ChargesController < ApplicationController

  def new
  end

  def create

    # Amount in cents
    # params[:charge][:amount] = params[:amount]
    # params[:charge][:student_id] = params[:student_id]

    @charge = Charge.new(params_charge)
    @charge.save
      @amount = 500

      customer = Stripe::Customer.create(
        :email => 'example@stripe.com',
        :card  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
      )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to students_path
    end

    private
    def params_charge
      params.require(:charge).permit(:student_id, :amount)
    end

end
