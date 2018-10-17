class SearchController < ApplicationController

  def index
    respond_with(@posts = @post_search.result.order('created_at DESC'))
  end

end
