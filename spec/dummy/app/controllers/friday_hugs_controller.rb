class FridayHugsController < ApplicationController

  def create
    render text: params.inspect + "\n"
  end

end
