module API::HistoryRepresenter
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::Hypermedia
  include PaginationRepresenter

  #for pagination...
  delegate :current_page, :next_page, :previous_page, :total_entries,
           to: :versions

  collection :versions, embedded: true

  # Generates url in PaginationRepresenter
  def page_url(first, hsh)
    hsh = hsh.merge item_type: model.class.to_s,
                    item_id:   model.id.to_i
    api_history_path(first, hsh)
  end
end
