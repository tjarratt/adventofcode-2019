class Program
  def initialize(data)
    @data = data.dup
  end

  def [](index)
    raise Exception.new("invalid index: #{index}") if index < 0

    @data.fetch(index, 0)
  end

  def []=(index, value)
    raise Exception.new("invalid index: #{index}") if index < 0

    @data[index] = value
  end
end

