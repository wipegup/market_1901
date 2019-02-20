class Vendor
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(name)
    return @inventory[name]
  end

  def stock(name, quantity)
    @inventory[name] = quantity
  end
end
