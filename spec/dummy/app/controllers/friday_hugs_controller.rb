class FridayHugsController

  def create
    render text: params.inspect + "\n"
  end

end
