class Human {
  // Prop
  int id;
  String name;
  String address;
  DateTime birthdate;
  bool isMarried;

  // ctor

  Human(
    int id, String name, String address, DateTime birthdate, bool isMarried) {
    this.id = id;
    this.name = name;
    this.address = address;
    this.birthdate = birthdate;
    this.isMarried = isMarried;
  }

  void ShowHumanDetails() {
    print("ID id $id");
    print("Name id $name");
    print("Address id $address");
    print("DOB id $birthdate");
    print("Ismarried id $isMarried");
  }
}

void main() {
  Human human =
      new Human(1, "Pawanlal", "Jhapa", DateTime(1999, 10, 08), false);
  human.ShowHumanDetails();
}
