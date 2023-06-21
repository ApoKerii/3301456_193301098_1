class Categories {
  String? url;
  String? name;
}

List<Categories> getcategories() {
  List<Categories> categorieslist = [];
  Categories category = new Categories();

  category.url =
      "https://images.pexels.com/photos/3571551/pexels-photo-3571551.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260";
  category.name = "Nature";
  categorieslist.add(category);
  category = new Categories();

  category.url =
      "https://images.pexels.com/photos/572861/pexels-photo-572861.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  category.name = "Wildlife";
  categorieslist.add(category);
  category = new Categories();

  category.url =
      "https://images.pexels.com/photos/358238/pexels-photo-358238.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  category.name = "Landscape";
  categorieslist.add(category);
  category = new Categories();

  category.url =
      "https://images.pexels.com/photos/3152174/pexels-photo-3152174.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  category.name = "Street Art";
  categorieslist.add(category);
  category = new Categories();

  category.url =
      "https://images.pexels.com/photos/1980720/pexels-photo-1980720.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260";
  category.name = "City";
  categorieslist.add(category);
  category = new Categories();

  category.url =
      "https://images.pexels.com/photos/2549050/pexels-photo-2549050.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  category.name = "Statue";
  categorieslist.add(category);
  category = new Categories();

  category.url =
      "https://images.pexels.com/photos/73873/star-clusters-rosette-nebula-star-galaxies-73873.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260";
  category.name = "Space";
  categorieslist.add(category);
  category = new Categories();

  category.url =
      "https://images.pexels.com/photos/112460/pexels-photo-112460.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  category.name = "Cars";
  categorieslist.add(category);
  category = new Categories();

  return categorieslist;
}