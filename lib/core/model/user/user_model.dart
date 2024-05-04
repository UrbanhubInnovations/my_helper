import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';


part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  @HiveType(
    typeId: 2,
    adapterName: 'UserAdapter',
  )
  const factory UserModel({
    @HiveField(0) required String name,
    @HiveField(1) required String email,
    @HiveField(2) required String password,
    @HiveField(3) required int pin,
    @HiveField(4) required String createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
