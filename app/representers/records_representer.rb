class RecordsRepresenter
  def initialize(records)
    @records = records
  end

  def as_json
    records_output = @records.map do |record|
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
        total_records: records.length
      }
    })
  end
  
  private

  attr_reader :records
  
end