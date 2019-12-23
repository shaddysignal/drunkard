defprotocol Drunkard.Recipes.Slug do
  @spec slugify(map) :: String.t()
  def slugify(map)
end
