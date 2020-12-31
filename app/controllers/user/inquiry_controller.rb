class User::InquiryController < ApplicationController

  before_action :authenticate_user!

  def index
    @inquiry = Inquiry.new
    render :action => 'index'
  end

  def confirm
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    @inquiry.valid? ? render :action => 'confirm' : render :action => 'index'
  end

  def thanks
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))    
    InquiryMailer.received_email(@inquiry).deliver
    InquiryMailer.confirm_email(@inquiry).deliver
    render :action => 'thanks'
  end
  
end
