require 'rails_helper'

RSpec.feature "SongComments", type: :feature do

  let(:user) { FactoryBot.create(:user)}

  before do
    visit root_path
    click_link "LOG_IN"
    fill_in "user_email",	with: user.email
    fill_in "user_password", with: user.password
    click_button "Log in"
    fill_in "search", with: "a"
    click_button "検索"
    click_link "song_1"
  end

  it "新規コメント作成" do
    expect{
      fill_in "song_comment_comment", with: "test"
      click_button "送信する"
    }.to change(user.song_comments, :count).by(1)
  end
end
