class Parser
  def initialize file:, upload_id:
    return nil unless file
    @file_as_array = file
    @upload_id = upload_id
  end

  def parse_while_storing_on_redis!
    # Stored as:
    # {
    #   UPLOAD_ID: {
    #     TYPE_1: [object_1, object_2, 3] ...,
    #     TYPE_2: [object_1, object_2, 3] ...,
    #   }
    # }
    to_be_stored = {@upload_id => {}}

    self.for_each_object_described do |inp_object|
      obj_type  = inp_object.inp_object_type
      obj_attrs = inp_object.to_h

      to_be_stored[@upload_id][obj_type] ||= Array.new
      to_be_stored[@upload_id][obj_type] << obj_attrs
    end

    REDIS.set(@upload_id, to_be_stored.to_json)
  end

  def for_each_object_described &block
    current_inp = InpObject.new

    @file_as_array.each do |file_line|
      line = Line.new file_line

      current_inp.populate_with(line, block)
    end
  end
end
