class Parser::File
  attr_accessor :name, :body, :type

  module ATTR_KEYS
    OBJ_NAME = 'name'
    OBJ_TYPE = 'inp_object_type'
  end

  def initialize upload
    @upload = upload
    @name = "inp-from-upload-#{@upload.id}.inp"
    @type = 'text/plain'
  end

  def generate
    records = @upload.records[@upload.id.to_s]

    to_return = ""

    records.each do |record_type, actual_records|
      actual_records.each do |record_attributes|
        record_attributes.each do |attr_name, attr_value|
          if attr_name.eql?(ATTR_KEYS::OBJ_NAME)
            to_return <<  "#{attr_value} = #{record_type}\n"
            next
          end

          next if attr_name.eql?(ATTR_KEYS::OBJ_TYPE)

          attr_value = "\"#{attr_value}\"" if attr_value.is_a?(String)
          to_return << "  #{attr_name.upcase.gsub("_", "-")} = #{attr_value}\n"
        end

        to_return << "  ..\n\n"
      end
    end

    to_return
  end

  def generate!
    @body = generate
    self
  end
end
