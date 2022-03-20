class Menu {
  late String ID;
  late String name;
  late int amount;
  late String image;

  Menu.fromJson(dynamic json) {
    this.ID = json["ID"];
    this.name = json["name"];
    this.amount = json["amount"];
    this.image = json["image"];
  }
}
