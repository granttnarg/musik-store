class LikeRepresenter
  def initialize(like)
    @like = like
    @record = Record.find(like.record_id)
  end

  def as_json
      {
        id: @like.id,
        user_id: @like.user_id,
        record: {
          record_id: @record.id,
          title: @record.title,
        }
      }
  end
  
  private

  attr_reader :record
  attr_reader :like
  
end