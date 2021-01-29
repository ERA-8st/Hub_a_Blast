class User::InquiryController < ApplicationController

  before_action :authenticate_user!

  def index
    @inquiry = Inquiry.new
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    render :index if @inquiry.invalid?
  end

  def thanks
    @inquiry = Inquiry.new(inquiry_params)    
    InquiryMailer.received_email(@inquiry).deliver
    InquiryMailer.confirm_email(@inquiry).deliver
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :message)
  end
  
end
