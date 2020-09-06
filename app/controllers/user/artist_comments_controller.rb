class User::ArtistCommentsController < ApplicationController

	def create
		@artist_comment = current_user.artist_comments.new(artist_comment_params)
		@artist_comment.artist_id = params[:artist_comment][:artist_id]
		if @artist_comment.save 
			redirect_back(fallback_location: root_path)
		else
			redirect_back(fallback_location: root_path)
		end

	end

	def update
		@comment = ArtistComment.find(params[:id])
      if @comment.update(artist_comment_params)
				redirect_to user_spotify_artist_show_path(@comment.artist_id)
			else
				redirect_back(fallback_location: root_path)
			end
	end
	
	def destroy
		comment = ArtistComment.find(params[:id])
		comment.destroy
		redirect_back(fallback_location: root_path)
	end

	private

	def artist_comment_params
		params.require(:artist_comment).permit(:comment)
	end

end
