class PostsController < ApplicationController
	before_filter :authenticate_user!
	def index
		@posts=Post.all
		@list=Post.order("view_count DESC").limit(3)
	end
	def new
		@post=Post.new
	end
	def create
		@post = Post.new(post_params)
		respond_to do |format|
			if @post.save
				format.html { redirect_to @post, notice: 'Post was successfully created.' }
				format.json { render action: 'show', status: :created, location: @post }
			else
				format.html { render action: 'new' }
				format.json { render json: @post.errors, status: :unprocessable_entity }
			end
		end
	end
	def show
		@post = Post.find(params[:id])
		@post.increment(:view_count)
		@post.save
	end
	def most_viewed
		
	end
	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		respond_to do |format|
			format.html { redirect_to posts_url }
			format.json { head :no_contentpost  }
		end
	end

	def post_params
		params.require(:post).permit(:post,:user_id)
	end

end
