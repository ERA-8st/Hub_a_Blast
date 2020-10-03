class User::SongCommentsController < ApplicationController

	before_action :correct_user, only: [:update, :destroy]

	def create
		@song_comment = current_user.song_comments.new(song_comment_params)
		@song_comment.song_id = params[:song_comment][:song_id]
		@page = params[:page]
		if @song_comment.save 
			redirect_to user_spotify_song_show_path(@song_comment.song_id, page: @page)
		else
			@song = RSpotify::Track.find(@song_comment.song_id)
			@album = @song.album
			@song_comments = SongComment.where(song_id: @song.id).order("id DESC").page(params[:page]).per(5)
			if user_signed_in?
				@song_rating = current_user.song_ratings.find_by(song_id: @song.id)
				@new_song_rating = current_user.song_ratings.new
			end
			@song_favorite = SongFavorite.find_by(user_id: current_user, song_id: @song.id)
			@error = true
			render "user/spotify/song_show"
		end

	end

	def update
		@comment = SongComment.find(params[:id])
		@page = params[:page]
		if @comment.update(song_comment_params)
			redirect_to user_spotify_song_show_path(@comment.song_id, page: @page)
		else
			@song = RSpotify::Track.find(@comment.song_id)
			@album = @song.album
			@song_comment = SongComment.new
			@song_comments = SongComment.where(song_id: @song.id).order("id DESC").page(params[:page]).per(5)
			@page = params[:page]
			if user_signed_in?
				@song_rating = current_user.song_ratings.find_by(song_id: @song.id)
				@new_song_rating = current_user.song_ratings.new
			end
			@song_favorite = SongFavorite.find_by(user_id: current_user, song_id: @song.id)
			@error = true
			render "user/spotify/song_show"
		end
	end
	
	def destroy
		comment = SongComment.find(params[:id])
		comment.destroy
		redirect_to user_spotify_song_show_path(comment.song_id)
	end

	private

	def song_comment_params
		params.require(:song_comment).permit(:comment)
	end

	def correct_user
		comment = SongComment.find(params[:id])
		unless current_user == comment.user
			redirect_to root_path
		end
	end
    
end
