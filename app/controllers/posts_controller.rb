class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  before_filter :current_controller #Findes i application_controller.rb
  before_filter :logged_in_as_admin?, :except => ['show']
  

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order('position')
  end

	def sort
	  params[:post].each_with_index do |id, index|
	    Post.update_all({position: index+1}, {id: id})
	  end
	  render nothing: true
	end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @attachments = Attachment.find_all_by_attachable_id(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        #format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.html { redirect_to action: 'index' }
				flash[:notice] = 'Indlægget blev oprettet'
        format.json { render action: 'edit', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to edit_post_path(@post), notice: 'Indlægget blev opdateret.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
	
  def active
    active_or_not(params[:id],'post', 'active')
    redirect_to action: 'index'
  end	

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :position, :parent_id, :user_id, :active)
    end
end
