require File.join(File.dirname(__FILE__), 'gilded_rose')

describe Item do

  describe "#daily_item_update" do
    it "does not change the name" do
      item = StandardItem.new("foo", 0, 0)
      expect(item.name).to eq "foo"
    end

    it "degrades quality of normal item by 1" do
      item = StandardItem.new("foo",10,20)
      item.tick
      expect(item.quality).to eq 19
    end

    it "degrades quality of normal item by 2 when sell_in is at 0" do
      item = StandardItem.new("foo",0,20)
      item.tick
      expect(item.quality).to eq 18
    end

    it "degrades quality of Conjured item by 2" do
      item = Conjured.new("Conjured",10,20)
      item.tick
      expect(item.quality).to eq 18
    end

    it "degrades quality of Conuured item by 4 when sell_in is at 0" do
      item = Conjured.new("foo",0,20)
      item.tick
      expect(item.quality).to eq 16
    end

    it "degrades sell_in of normal item by 1" do
      item = StandardItem.new("foo",10,20)
      item.tick
      expect(item.sell_in).to eq 9
    end

    it "cannot increase quality of backstage  above 50" do
      item = BackstagePass.new("Backstage passes to a TAFKAL80ETC concert",10,50)
      item.tick
      expect(item.quality).to eq 50
    end

    it "cannot increase quality of item above 50" do
      item = AgedBrie.new("Aged Brie",10,50)
      item.tick
      expect(item.quality).to eq 50
    end

    it "increases quality of Brie by 1" do
      item = AgedBrie.new("Aged Brie",10,20)
      item.tick
      expect(item.quality).to eq 21
    end



    it "cannot degrade quality below 0" do
      item = StandardItem.new("foo", 0, 0)
      item.tick()
      expect(item.quality).to eq 0
    end

    it "increase quality of Backstage passes by 2 when sell_in is in between 6 and 10 days" do
      item = BackstagePass.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)
      item.tick()
      expect(item.quality).to eq 12
    end

    it "increase quality of Backstage passes by 3 when sell_in is in between 1 and 5 days" do
      item = BackstagePass.new("Backstage passes to a TAFKAL80ETC concert", 4, 10)
      item.tick()
      expect(item.quality).to eq 13
    end

    it "reduces quality of Backstage passes to 0 when sell_in is 0" do
      item = BackstagePass.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)
      item.tick()
      expect(item.quality).to eq 0
    end
  end

end




describe GildedRose do

  describe "#daily_item_update" do
    it "does not change the name" do
      items = [StandardItem.new("foo", 0, 0)]
      GildedRose.new(items).daily_item_update()
      expect(items[0].name).to eq "foo"
    end

    it "degrades quality of normal items by 1" do
      items = [StandardItem.new("foo",10,20)]
      GildedRose.new(items).daily_item_update
      expect(items[0].quality).to eq 19
    end

    it "degrades quality of normal items by 2 when sell_in is at 0" do
      items = [StandardItem.new("foo",0,20)]
      GildedRose.new(items).daily_item_update
      expect(items[0].quality).to eq 18
    end

    it "degrades sell_in of normal items by 1" do
      items = [StandardItem.new("foo",10,20)]
      GildedRose.new(items).daily_item_update
      expect(items[0].sell_in).to eq 9
    end

    it "cannot increase quality of backstage  above 50" do
      items = [BackstagePass.new("Backstage passes to a TAFKAL80ETC concert",10,50)]
      GildedRose.new(items).daily_item_update
      expect(items[0].quality).to eq 50
    end

    it "cannot increase quality of items above 50" do
      items = [AgedBrie.new("Aged Brie",10,50)]
      GildedRose.new(items).daily_item_update
      expect(items[0].quality).to eq 50
    end

    it "increases quality of Brie by 1" do
      items = [AgedBrie.new("Aged Brie",10,20)]
      GildedRose.new(items).daily_item_update
      expect(items[0].quality).to eq 21
    end

    it "quality of Sulfruras stays the same" do
      items = [Item.new("Sulfuras, Hand of Ragnaros",10,20)]
      GildedRose.new(items).daily_item_update
      expect(items[0].quality).to eq 20
    end

    it "sell_in of Sulfruras stays the same" do
      items = [Item.new("Sulfuras, Hand of Ragnaros",10,20)]
      GildedRose.new(items).daily_item_update
      expect(items[0].sell_in).to eq 10
    end


    it "cannot degrade quality below 0" do
      items = [StandardItem.new("foo", 0, 0)]
      GildedRose.new(items).daily_item_update()
      expect(items[0].quality).to eq 0
    end

    it "increase quality of Backstage passes by 2 when sell_in is in between 6 and 10 days" do
      items = [BackstagePass.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
      GildedRose.new(items).daily_item_update()
      expect(items[0].quality).to eq 12
    end

    it "increase quality of Backstage passes by 3 when sell_in is in between 1 and 5 days" do
      items = [BackstagePass.new("Backstage passes to a TAFKAL80ETC concert", 4, 10)]
      GildedRose.new(items).daily_item_update()
      expect(items[0].quality).to eq 13
    end

    it "reduces quality of Backstage passes to 0 when sell_in is 0" do
      items = [BackstagePass.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
      GildedRose.new(items).daily_item_update()
      expect(items[0].quality).to eq 0
    end
  end
end
