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
