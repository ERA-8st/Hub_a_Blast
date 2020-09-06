class User::SongCommentsController < ApplicationController

	def create
		@song_comment = current_user.song_comments.new(song_comment_params)
		@song_comment.song_id = params[:song_comment][:song_id]
		if @song_comment.save 
			redirect_back(fallback_location: root_path)
		else
			redirect_back(fallback_location: root_path)
		end

	end

	def update
		@comment = SongComment.find(params[:id])
		if @comment.update(song_comment_params)
			redirect_to user_spotify_song_show_path(@comment.song_id)
		else
			redirect_back(fallback_location: root_path)
		end
	end
	
	def destroy
		comment = SongComment.find(params[:id])
		comment.destroy
		redirect_back(fallback_location: root_path)
	end

	private

	def song_comment_params
		params.require(:song_comment).permit(:comment)
	end
    
end
