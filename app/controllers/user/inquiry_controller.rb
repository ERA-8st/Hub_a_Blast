class User::InquiryController < ApplicationController

  before_action :authenticate_user!

  def index
    @inquiry = (params[:inquiry] ? Inquiry.new(inquiry_params) : Inquiry.new )
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    render :index if @inquiry.invalid?
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)    
    InquiryMailer.received_email(@inquiry).deliver
    InquiryMailer.confirm_email(@inquiry).deliver
    redirect_to user_inquiry_thanks_path
  end

  def thanks
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :message)
  end
  
end
