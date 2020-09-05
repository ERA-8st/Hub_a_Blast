class User::ArtistCommentsController < ApplicationController

	def create
		@artist_comment = current_user.artist_comments.new(artist_comment_params)
		@artist_comment.artist_id = params[:artist_comment][:artist_id]
		if @artist_comment.save 
			redirect_back(fallback_location: root_path)
		else
			render "user/spotify/artist_show"
		end

	end


	private

	def artist_comment_params
		params.require(:artist_comment).permit(:comment)
	end

end
