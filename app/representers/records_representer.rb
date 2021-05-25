class RecordsRepresenter
  def initialize(records)
    records.class == Record ? @records = [records] : @records = records
  end

  def as_json
    records.map do |record|
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

  attr_reader :records
  
end