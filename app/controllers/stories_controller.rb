class StoriesController < ApplicationController
  def index
     @stories = Story.all.includes(:category, :ratings, :user)
  end

  def destroy
    story = Story.find(params[:id])
    story.destroy
    redirect_to :back
  end

  def new
    @story = Story.new
  end

  def edit
    @story = Story.find(params[:id])
    render "stories/new", {:story => @story}
  end

  def translate
    story = Story.find(params[:id])
    if params[:translate_to] == 'original'
      render json: { title: story.title, content: story.content }
    else
      title, content = TranslateService.translate_text(story, params[:translate_to])
      render json: { title: title, content: content }
    end
  end

  private
  def story_params
    params.require(:story).permit(:category_id, :user_id, :title, :rating)
  end
end