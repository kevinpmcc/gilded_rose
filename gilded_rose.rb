class GildedRose


  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.decrease_sell_in
        item.update_quality
      end
    end
  end
end



class Item

  MAXIMUM_QUALITY = 50
  attr_reader :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end

  def decrease_sell_in
    if @sell_in > 0
      @sell_in -=1
    end
  end

  def increase_quality(amount)
    @quality += amount if @quality < MAXIMUM_QUALITY
  end

  def decrease_quality(amount)
    @quality -= amount if @quality > 0
  end
end

class AgedBrie < Item

  def update_quality
    increase_quality(1)
  end

end


class BackstagePass < Item

  def update_quality
    case @sell_in
    when 0
      decrease_quality(@quality)
    when 11..49
      increase_quality(1)
    when 6..10
      increase_quality(2)
    when 1..5
      increase_quality(3)
    end
  end
end




class StandardItem < Item

STANDARD_ITEM_QUALITY_DEGRADATION = 1

  def update_quality
    if @quality > 0
      if @sell_in > 0
        decrease_quality(STANDARD_ITEM_QUALITY_DEGRADATION)
      else
        decrease_quality(STANDARD_ITEM_QUALITY_DEGRADATION * 2)
      end
    end
  end
end




=begin
  def another_method
    if true == true
      puts "I shouldn't exist"
    else item.name != "Sulfuras, Hand of Ragnaros"
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        standard_item(item)
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.sell_in = item.sell_in - 1
          end
          if item.sell_in < 0
            if item.name != "Aged Brie"
              if item.name != "Backstage passes to a TAFKAL80ETC concert"
                if item.quality > 0
                  if item.name != "Sulfuras, Hand of Ragnaros"
                    item.quality = item.quality - 1
                  end
                end
              else
                item.quality = item.quality - item.quality
              end
            else
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
    end
  end
=end
