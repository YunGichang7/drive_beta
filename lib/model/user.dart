class User{
  int user_id;
  String user_name;
  String car_number;

  User(this.user_id, this.user_name, this.car_number);

  Map<String, dynamic> toJson() => {
    'user_id' : user_id.toString(),
    'user_name' : user_name,
    'car_number' : car_number
  };
}