import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String age;

  @HiveField(3)
  String phone;

  @HiveField(4)
  String image;

  StudentModel(this.name, this.age, this.phone, this.image, [this.id]);
}
