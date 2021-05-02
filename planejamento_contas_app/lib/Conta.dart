class Conta {
  int id;
  String title;
  double value;
  bool isPaid;

  Conta({
    this.id,
    this.title,
    this.value,
    this.isPaid,
  });

  factory Conta.fromMap(Map<String, dynamic> json) => new Conta(
    id: json["id"],
    title: json["title"],
    value: json["value"],
    isPaid: json["isPaid"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "value": value,
    "isPaid": isPaid,
  };
}