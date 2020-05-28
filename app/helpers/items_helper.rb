module ItemsHelper
  def search_result(keyword)
    if keyword.present?
      "「#{@keyword}」の検索結果" 
    else
      "検索結果"
    end
  end
end
