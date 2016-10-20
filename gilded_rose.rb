# GildedRose class takes an array of items
# and updates each one by calling instance methods
class GildedRose
  def initialize(items)
    @items = items
  end

  def daily_item_update
    @items.each do |item|
      item.tick if item.name != 'Sulfuras, Hand of Ragnaros'
    end
  end
end

# is a superclass which all other item classes inherit from
class Item
  attr_reader :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

# module which has behaviour to instigate to ammend
# sell_in and quality for items
module AmmendItems
  MAXIMUM_QUALITY = 50

  def tick
    decrease_sell_in
    update_quality
  end

  private
  def decrease_sell_in
    @sell_in -= 1 if sell_in > 0
  end

  def increase_quality(amount)
    @quality += amount if quality < MAXIMUM_QUALITY
  end

  def decrease_quality(amount)
    @quality -= amount if quality > 0
  end
end

# is a subclass which inherits from Item.
# Its specifically for any instances of AgedBrie
class AgedBrie < Item
  include AmmendItems

  private
  def update_quality
    increase_quality(1)
  end
end

# is a subclass which inherits from Item.
# It adds the behaviour of updating quality for different cases
class BackstagePass < Item
  include AmmendItems

  private

  def update_quality
    if sell_in == 0
      decrease_quality(quality)
    else
      increase_quality(quality_increase_amount)
    end
  end

  def quality_increase_amount
    case sell_in
    when 11..49
      1
    when 6..10
      2
    when 1..5
      3
    end
  end

end
# StandardItem is for items which stick to standard rules
# decreae of quality at 1 a day up till sell_by daily_item_update
# then decrease of quality at 2 a day after sell_by date
class StandardItem < Item
  include AmmendItems

  private
  QUALITY_DEGRADATION_RATE = 1

  def update_quality
    if sell_in > 0
      decrease_quality(QUALITY_DEGRADATION_RATE)
    else
      decrease_quality(QUALITY_DEGRADATION_RATE * 2)
    end
  end
end

# StandardItem is for items which stick to standard rules
# decreae of quality at 1 a day up till sell_by daily_item_update
# then decrease of quality at 2 a day after sell_by date
class Conjured < StandardItem

  private
  QUALITY_DEGRADATION_RATE = 2
  def update_quality
    if sell_in > 0
      decrease_quality(QUALITY_DEGRADATION_RATE)
    else
      decrease_quality(QUALITY_DEGRADATION_RATE * 2)
    end
  end
end
