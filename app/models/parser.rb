class Parser
  def initialize file
    return nil unless file
    @file = file
  end

  def get_all
    for_each_object_described_in(@file) do |inp_object|
      ap inp_object
    end

    nil
  end

  def for_each_object_described_in file, &block
    current_inp = InpObject.new

    File.readlines(file).each do |file_line|
      line = Line.new file_line

      current_inp.populate_with(line, block)
    end
  end
end
