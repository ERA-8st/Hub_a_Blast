class User::AlbumCommentsController < ApplicationController

	def create
		@album_comment = current_user.album_comments.new(album_comment_params)
		@album_comment.album_id = params[:album_comment][:album_id]
		if @album_comment.save 
			redirect_back(fallback_location: root_path)
		else
			redirect_back(fallback_location: root_path)
		end

	end


	private

	def album_comment_params
		params.require(:album_comment).permit(:comment)
	end

end
