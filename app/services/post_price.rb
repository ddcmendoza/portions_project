class PostPrice < ApplicationService
  def initialize(price)
    super
    @price = price
  end

  def call; end
end
