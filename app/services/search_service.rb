class SearchService
  def initialize(model, query, sort, fields)
    @model = model
    @query = query
    @sort = sort
    @fields = fields
  end

  def call
    if @query.present?
      @model.search(
        @query,
        fields: @fields,
        operator: "or",
        order: sort_by(@sort),
        match: :word_middle
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
