class SearchService
  def initialize(model, fields, query, sort, page, per_page)
    @model = model
    @query = query
    @sort = sort
    @fields = fields
    @page = page
    @per_page = per_page
  end

  def call
    if @query.present?
      @model.search(
        @query,
        fields: @fields,
        operator: "or",
        order: sort_by(@sort),
        match: :word_middle,
        page: @page,
        per_page: @per_page
      )
    else
      @model.search('*')
    end
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
