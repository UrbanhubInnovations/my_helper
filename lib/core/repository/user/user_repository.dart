import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../model/user/user_model.dart';

@lazySingleton
class UserRepository {
  final Box<UserModel> _userBox;

  const UserRepository(this._userBox);

  UserModel? get user => _userBox.get('user');

  Future<void> saveUser(UserModel user) async =>  _userBox.put('user', user);

  Future<void> reset() async =>  _userBox.clear();
}
