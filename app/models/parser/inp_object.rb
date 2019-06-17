class Parser::InpObject < OpenStruct

  def populate_with line, block
    unless line.comment?
      if line.end_of_object_description?
        block.call(self)
        self.clean()
      end

      unless line.empty?
        if self.started?
          self[line.attr] = line.value

        else
          self.name = line.name
          self.inp_object_type = line.inp_object_type
        end
      end
    end
  end

  def store_on_redis upload_id
    # Stored as:
    # {
    #   UPLOAD_ID: {
    #     TYPE_1: [object_1, object_2, 3] ...,
    #     TYPE_2: [object_1, object_2, 3] ...,
    #   }
    # }
    REDIS.set(upload_id, {}) if REDIS.get(upload_id).blank?

    objects_from_upload_id = JSON.parse REDIS.get(upload_id)
    objects_from_type = objects_from_upload_id.fetch(self.inp_object_type, [])
    objects_from_type << self.to_h
    objects_from_upload_id[self.inp_object_type] = objects_from_type

    REDIS.set(upload_id, objects_from_upload_id.to_json)
  end

  protected

    def started?
      self.name.present? && self.inp_object_type.present?
    end

    def clean
      each_pair do |key, value|
        next if [:line, :block].include?(key)
        self.delete_field(key)
      end
    end
end
