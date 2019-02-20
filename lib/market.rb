class Market
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendors_that_sell(item)
    @vendors.find_all{|vendor| vendor.inventory[item] >0}
  end
end
