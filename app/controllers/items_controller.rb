class ItemsController < ApplicationController
  def new
    @items = []
    
    @keyword = params[:keyword]
    if @keyword.present?
      #resulsは楽天APIより商品情報を一時取得
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      })
      
      
      results.each do |result|
        item = Item.new(read(result))
        #items配列の最後にitem要素を追加
        @items << item
      end
    end
  end
  
  private
  
  # 検索によって得られた情報を扱いやすくするための整形
  def read(result)
    code = result['itemCode']
    name = result['itemName']
    url = result['itemUrl']
    image_url = result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')
    
    {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end
end
