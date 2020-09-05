class User::SongCommentsController < ApplicationController

	def create
		@song_comment = current_user.song_comments.new(song_comment_params)
		@song_comment.song_id = params[:song_comment][:song_id]
		if @song_comment.save 
			redirect_back(fallback_location: root_path)
		else
			render "user/spotify/song_show"
		end

	end


	private

	def song_comment_params
		params.require(:song_comment).permit(:comment)
	end
    
end
