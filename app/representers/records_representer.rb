class RecordsRepresenter
  def initialize(records)
    records.class == Record ? @records = [records] : @records = records
  end

  def as_json
    records_output = records.map do |record|
      {
        id: record.id,
        title: record.title,
        description: record.description,
        genre: record.genre,
        album: record.album,
        like_count: record.like_count,
        artist: {
          artist_id: record.artist_id,
          name: record.artist.name,
          bio: record.artist.bio
        }
      }
    end
    records_output.insert(0, {
      meta: {
        path: "api/v1/records",
        endpoint_type: "public",
        records: records.length
      }
    })
  end
  
  private

  attr_reader :records
  
end