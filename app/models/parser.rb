class Parser
  def initialize file
    return nil unless file
    @file_as_array = file
  end

  def get_all
    all = []

    for_each_object_described do |inp_object|
      all << inp_object.inspect
    end

    all
  end

  def for_each_object_described &block
    current_inp = InpObject.new

    @file_as_array.each do |file_line|
      line = Line.new file_line

      current_inp.populate_with(line, block)
    end
  end
end
