class RestaurantModel {
  final String name;
  final int times;
  final int stackPoint;

  RestaurantModel({this.name, this.times, this.stackPoint,});
}

List<RestaurantModel> dummyData = [
  new RestaurantModel(
      name: "Kung Fu Tea",
      times: 10,
      stackPoint:100,
  ),
  new RestaurantModel(
    name: "Red Hot Hot Pot",
    times: 5,
    stackPoint:500,
  ),
  new RestaurantModel(
    name: "kuro kuma espresso & coffee",
    times: 12,
    stackPoint:120,
  ),
  new RestaurantModel(
    name: "SzeChuanMountainHouse",
    times: 1,
    stackPoint:100,
  ),
];