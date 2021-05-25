class RecordRepresenter
  def initialize(record)
    @record = record
  end

  def as_json
      {
        id: record.id,
        title: record.title,
        description: record.description,
        genre: record.genre,
        artist: {
          artist_id: record.artist_id,
          name: record.artist.name,
          bio: record.artist.bio
        }
      }
    end
  end
  
  private

  attr_reader :record
  
end