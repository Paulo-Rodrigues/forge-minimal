require_relative '../objects/objects'

class Environment
  attr_accessor :store

  def initialize(parent_store = nil)
    @store = parent_store || {}
  end

  def set(name, value)
    store[name] = value
  end

  def get(name)
    store[name] || ForgeNull.new
  end
end
