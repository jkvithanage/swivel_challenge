class Api::V1::SearchController < ApplicationController
  def search
    if params[:query].blank?
      render json: { error: 'Query parameter is missing' }, status: :bad_request
      return
    end

    results = Searchkick.search(
      params[:query],
      models: [Vertical, Category, Course],
      fields: [:name, :author],
      operator: "or",
      match: :word_middle,
      order: sort_by(params[:sort]),
      page: params[:page],
      per_page: 10
    )

    render json: results, meta: { total: results.total_count, total_pages: results.total_pages, current_page: results.current_page }
  end

  private

  def sort_by(option)
    case option
    when "created_at"
      { created_at: :desc }
    when "alphabetical"
      { name: :asc }
    else
      { _score: :desc }
    end
  end
end
