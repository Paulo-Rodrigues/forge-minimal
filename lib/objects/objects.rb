class ForgeObject
  def inspect
    to_s
  end
end

class ForgeNull < ForgeObject
  def to_s
    'null'
  end
end

class ForgeNumber < ForgeObject
  attr_reader :value

  def initialize(value)
    @value = value.to_i
  end

  def +(other)
    ForgeNumber.new(value + other.value)
  end

  def -(other)
    ForgeNumber.new(value - other.value)
  end

  def *(other)
    ForgeNumber.new(value * other.value)
  end

  def /(other)
    ForgeNumber.new(value / other.value)
  end

  def to_s
    value.to_s
  end
end