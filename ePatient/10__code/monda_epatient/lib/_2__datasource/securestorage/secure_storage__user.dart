import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:monda_epatient/_1__model/user.dart';

class UserSecureStorage {
  // =============================================================== Boilerplate
  UserSecureStorage.newInstance();

  static UserSecureStorage get instance => Get.find();

  // ================================================================ Attributes
  late FlutterSecureStorage _storage;

  User? _user;

  // ============================================================= Setter Getter
  set user(User? user) {
    _user = user;
    _writeToStorage(user);
  }

  User? get user => _user;

  // ============================================================= Public method
  void init() async {
    _storage = new FlutterSecureStorage();

    _readFromStorage().then((user) {
      _user = user;
    });
  }

  void remove() {
    _user = null;
    _storage.deleteAll();
  }


  // ============================================================ Private method
  Future<User?> _readFromStorage() async {
    User? user;

    Map<String, String> _allValues = await _storage.readAll();
    if(_allValues['User__id'] != null) {
      user = User(
        id: _allValues['User__id']!,
        userName: _allValues['User__userName'],
        firstName: _allValues['User__firstName'],
        location: _allValues['User__location'],
        imageUrl: _allValues['User__imageUrl'],
      );
    }

    return user;
  }

  void _writeToStorage(User? user) {
    if(user != null) {
      _storage.write(key: 'User__id', value: user.id);
      _storage.write(key: 'User__userName', value: user.userName);
      _storage.write(key: 'User__firstName', value: user.firstName);
      _storage.write(key: 'User__location', value: user.location);
      _storage.write(key: 'User__imageUrl', value: user.imageUrl);
    }
  }
}
