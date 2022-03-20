class Order {
  late String ID;
  late String table;
  DateTime? dateTime;
  late String menuID;
  late int amount;
  late int count;

  Order.fromJson(dynamic json) {
    this.ID = json["ID"];
    this.table = json["table"];
    this.menuID = json["menuID"];
    this.amount = json["amount"];
  }
}
