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

  def sorted_item_list
    items = []
    @vendors.each do |vendor|
      items += vendor.inventory.keys
    end
    items.uniq.sort
  end

  def total_inventory
    sorted_item_list.inject(Hash.new(0)) do |agg_hash, item|
      agg_hash[item] = vendors_that_sell(item).sum{ |vendor| vendor.check_stocks(item)}
      agg_hash
    end
  end

  def sell(item, quantity)
    return false if total_inventory[item] >= quantity == false

    to_sell = quantity
    vendors = vendors_that_sell(item)
    vendors.each do |vendor|
      vendor_stock = vendor.check_stock(item)
      if vendor_stock >= to_sell
        vendor.stock(item, -to_sell)
        return true
      else
        to_sell -= vendor_stock
        vendor.stock(item, -vendor_stock)
      end
    end
  end
end
