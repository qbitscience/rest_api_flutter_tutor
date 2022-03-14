class Student
{
  late String name;
  late String id;
  Student({
    required this.name,
        required this.id
  });
  factory Student.fromJson(Map<String,dynamic> json)
  {
   return Student(name:json["name"],
       id:json["id"]);
  }

}