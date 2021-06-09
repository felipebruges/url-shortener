class Api::ShortUrlsController < ApplicationController
  before_action :authenticate_api_user!, except: :show
  before_action :find_short_url, only: :show

  def create
    short_url = ShortUrl.find_or_initialize_by(
      user: current_api_user,
      original: short_url_params[:url]
    )
    if short_url.persisted? || short_url.save
      render json: short_url
    else
      render json: { error: short_url.errors.full_messages }
    end
  end

  def show
    redirect_to find_short_url.original
  end

  private

  def short_url_params
    params.require(:short_url).permit(:url)
  end

  def find_short_url
    short_url = ShortUrl.find_by(slug: params[:id])
    return short_url if short_url

    render json: { error: 'Unable to find ShortUrl with the given slug.' }
  end
end
