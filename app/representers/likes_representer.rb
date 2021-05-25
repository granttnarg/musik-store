class LikesRepresenter
  def initialize(likes)
    @likes = likes
  end

  def as_json
    @likes.map do |like|
      record = Record.find(like.record_id)
      artist = Artist.find(record.artist_id)
      {
        id: like.id,
        user_id: like.user_id,
        record: {
          title: like.record.title,
          artist: artist.name 
        }
      }
    end
  end
  
  private

  attr_reader :records
  
end