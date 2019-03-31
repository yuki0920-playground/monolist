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
        item = Item.find_or_initialize_by(read(result))
        #items配列の最後にitem要素を追加
        @items << item
      end
    end
  end
  
  private
  
end
