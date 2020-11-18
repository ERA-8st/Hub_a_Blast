require 'rails_helper'

RSpec.feature "Users", type: :feature do
  
  describe "User" do
    # describe "ユーザー新規登録" do
    #   before do
    #     visit new_user_registration_path
    #   end
    #   context "新規登録画面に遷移" do
    #     it "新規登録に成功する" do
    #       fill_in "user[email]", with: "test@test"
    #       fill_in "user[user_name]", with: "test_user"
    #       fill_in "user[password]", with: "password"
    #       fill_in "user[password_confirmation]", with: "password"
    #       click_button "Sign up"

    #       expect(User.all.count).to eq 1  
    #     end

    #     it "新規登録に失敗する" do
    #       fill_in "user[email]", with: ""
    #       fill_in "user[user_name]", with: ""
    #       fill_in "user[password]", with: ""
    #       fill_in "user[password_confirmation]", with: ""
    #       click_button "Sign up"

    #       expect(User.all.count).to eq 0  
    #     end
        
    #   end
    # end

    # describe "ユーザーログイン" do
    #   let(:user) { create(:user) }
    #   before do
    #     visit new_user_session_path
    #   end
    #   context "ログイン画面に遷移" do
    #     it "ログインに成功する" do
    #       fill_in "user_email", with: user.email
    #       fill_in "user_password", with: user.password
    #       click_button "Log in"

    #       expect(current_path).to eq root_path  
    #     end

    #     it "ログインに失敗する" do
    #       fill_in "user_email", with: ""
    #       fill_in "user_password", with: ""
    #       click_button "Log in"

    #       expect(current_path).to eq new_user_session_path
    #     end
    #   end
    # end
    
    describe "ユーザー詳細" do
      let(:user) { create(:user) }
      let(:user2) { create(:user2) }
      # describe "ログインユーザーと詳細ユーザーが一致している場合" do
      #   before do
      #     visit new_user_session_path
      #     fill_in "user_email", with: user.email
      #     fill_in "user_password", with: user.password
      #     click_button "Log in"
      #     visit user_user_path(user.id)
      #   end
      #   context "ヘッダーのテスト" do
      #     let(:user_header) { find(".user-header")}
      #     context "表示のテスト" do
      #       it "ユーザー詳細リンクが表示される" do
      #         expect(user_header).to have_link "", href: user_user_path(user.id)
      #       end
      #       it "お気に入り一覧リンクが表示される" do
      #         expect(user_header).to have_link "", href: user_song_favorites_path(user_id: user.id)
      #       end
      #       it "ユーザー編集リンクが表示される" do
      #         expect(user_header).to have_link "", href: edit_user_user_path(user.id)  
      #       end
      #       it "通知一覧リンクが表示される" do
      #         expect(user_header).to have_link "", href: user_notifications_path
      #       end
      #       it "未読通知アイコンが表示される" do
      #         notification = create(:notification, visiter_id: user2.id, visited_id: user.id, action: "follow" )
      #         visit current_path
      #         expect(find(".user-notice")).to have_selector "p"
      #       end
      #     end
      #     context "リンクの確認" do
      #       it "ユーザー詳細に遷移する" do
      #         user_header.click_link "", href: user_user_path(user.id)
      #         expect(current_path).to eq user_user_path(user.id)
      #       end
      #       it "お気に入り一覧に遷移する" do
      #         user_header.click_link "", href: user_song_favorites_path(user_id: user.id)
      #         expect(current_path).to eq user_song_favorites_path
      #       end
      #       it "ユーザー編集画面に遷移する" do
      #         user_header.click_link "", href: edit_user_user_path(user.id)
      #         expect(current_path).to eq edit_user_user_path(user.id) 
      #       end
      #       it "通知一覧に遷移する" do
      #         user_header.click_link "", href: user_notifications_path
      #         expect(current_path).to eq user_notifications_path
      #       end
      #     end
          
      #   end
      #   context "ユーザー詳細のテスト" do
      #     context "表示のテスト" do
      #       it "ユーザー画像が表示される" do
      #         expect(find(".user-show-user-image")).to have_selector "img[src$='/assets/no-image-a8970a4d625bc37c078b5c74f8e6f65c9ad2110f5089a90c4b638e1d41cebc4b.png']"
      #       end
      #       it "ユーザー名が表示される" do
      #         expect(find(".user-show-user-name").text).to eq user.user_name
      #       end
      #       it "ユーザー詳細が表示される" do
      #         expect(find(".user-show-user-introduction").text).to eq user.introduction 
      #       end
      #       it "フォロー一覧リンクが表示される" do
      #         expect(find(".follow-follower")).to have_link "フォロー", href: user_users_follow_index_path(user)
      #       end
      #       it "フォロワー一覧リンクが表示される" do
      #         expect(find(".follow-follower")).to have_link "フォロワー", href: user_users_follower_index_path(user)
      #       end
      #     end
      #     context "リンクの確認" do
      #       it "フォロー一覧に遷移する" do
      #         find(".follow-follower").click_link "フォロー", href: user_users_follow_index_path(user)
      #       end
      #       it "フォロワー一覧に遷移する" do
      #         find(".follow-follower").click_link "フォロワー", href: user_users_follower_index_path(user)
      #       end
      #     end
      #   end
      #   context "Latest Chatsのテスト" do
      #     let(:latest_chats) { find(".latest-chats") }
      #     let(:room) { create(:room) }
      #     let!(:user_entry) { create(:entry, user: user, room: room) }
      #     let!(:user2_entry) { create(:entry, user: user2, room: room) }
      #     let!(:message) { create(:message, user: user, room: room) }
      #     before do
      #       visit current_path
      #     end
      #     context "表示のテスト" do
      #       it "タイトルが表示される" do
      #         expect(latest_chats).to have_content "Latest Chats"
      #       end
      #       it "直近のチャットユーザーが表示される" do
      #         expect(latest_chats).to have_link "", href: user_user_path(user2)
      #         expect(latest_chats).to have_selector "img[src$='/assets/no-image-a8970a4d625bc37c078b5c74f8e6f65c9ad2110f5089a90c4b638e1d41cebc4b.png']"
      #         expect(latest_chats).to have_content user2.user_name
      #         expect(latest_chats).to have_link "", href: user_room_path(room, pair_user_id: user2, anchor: "last")
      #       end
      #     end
      #     context "リンクの確認" do
      #       it "相手のユーザー詳細へ遷移する" do
      #         latest_chats.click_link "", href: user_user_path(user2)
      #         expect(current_path).to eq user_user_path(user2)  
      #       end
      #       it "相手とのRoomに遷移する" do
      #         latest_chats.click_link "", href: user_room_path(room, pair_user_id: user2, anchor: "last")
      #         expect(current_path).to eq user_room_path(room)
      #       end
      #     end
      #   end
      #   context "Latest Commentのテスト" do
      #     let(:latest_comment) { find(".latest-comment") }
      #     let!(:song_comment) { create(:song_comment, user: user) }
      #     before do
      #       visit current_path
      #     end
      #     context "表示のテスト" do
      #       it "タイトルが表示される" do
      #         expect(latest_comment).to have_content "Latest your comment"  
      #       end
      #       it "直近にコメントした曲が表示される" do
      #         expect(latest_comment).to have_link "", href: user_spotify_song_show_path(song_comment.song_id)
      #       end
      #     end
      #     context "リンクの確認" do
      #       it "曲詳細に遷移する" do
      #         latest_comment.click_link "", href: user_spotify_song_show_path(song_comment.song_id)
      #         expect(current_path).to eq user_spotify_song_show_path(song_comment.song_id)
      #       end
      #     end
      #   end
      #   context "favoriteのテスト" do
      #     let(:user_favorites) { find(".user-favorites") }
      #     let!(:song_favorite) { create(:song_favorite, user: user) }
      #     before do
      #       visit current_path
      #     end
      #     context "表示のテスト" do
      #       it "タイトルが表示される" do
      #         expect(user_favorites).to have_content "your favorite"
      #       end
      #       it "直近のブックマークした曲が表示される" do
      #         expect(user_favorites).to have_link "", href: user_spotify_song_show_path(song_favorite.song_id)
      #       end
      #     end
      #     context "リンクの確認" do
      #       it "曲詳細に遷移する" do
      #         user_favorites.click_link "", href: user_spotify_song_show_path(song_favorite.song_id)
      #         expect(current_path).to eq user_spotify_song_show_path(song_favorite.song_id)
      #       end
      #     end
      #   end
          
      # end
      describe "ログインユーザーと詳細ユーザーが異なる場合" do
        before do
          visit new_user_session_path
          fill_in "user_email", with: user2.email
          fill_in "user_password", with: user2.password
          click_button "Log in"
          visit user_user_path(user.id)
        end
        context "ヘッダーのテスト" do
          let(:user_header) { find(".user-header")}
          let!(:relationship) { create(:relationship, user_id: user2.id, follow_id: user.id) }
          context "相互フォローかつRoomが存在する場合" do
            let!(:relationship2) { create(:relationship2, user_id: user.id, follow_id: user2.id) }
            let(:room) { create(:room)}
            let!(:entry) { create(:entry, user: user2, room: room) }
            let!(:entry2) { create(:entry2, user: user, room: room) }
            before do
              visit current_path
            end
            it "Roomリンクが表示される" do
              expect(user_header).to have_link "", href: user_room_path(room, pair_user_id: user, anchor: "last")
            end
            it "リンクの数が正しい" do
              header_links = user_header.all("a")
              expect(header_links.count).to eq 3  
            end
          end
          # context "相互フォローかつRoomが存在しない場合" do
          #   let!(:relationship2) { create(:relationship2, user_id: user.id, follow_id: user2.id) }
          #   before do
          #     visit current_path
          #   end
          #   it "Roomクリエイトフォームが表示される" do
          #     expect(user_header).to have
          #   end
          #   it "リンク及びフォームの数が正しい" do
          #     header_links = user_header.all("a")
          #     header_forms = user_header.all("form")
          #     expect(header_links).to eq 2
          #     expect(header_forms).to eq 1
          #   end
          # end
          context "相互フォローでない場合" do
            it "リンクの数が正しい" do
              header_links = user_header.all("a")
              expect(header_links.count).to eq 2
            end
          end
            
        end
        context "ユーザー詳細のテスト" do
          
        end
        context "Latest Commentのテスト" do
          it "タイトルが正しく表示される" do
            expect(find(".latest-comment")).to have_content "Latest #{user.user_name}'s comment"  
          end
        end
        context "favoriteのテスト" do
          it "タイトルが正しく表示される" do
            expect(find(".user-favorites")).to have_content "#{user.user_name}'s favorite"
          end
        end
        
        
      end
      
      
    end
    
  end
  
end
