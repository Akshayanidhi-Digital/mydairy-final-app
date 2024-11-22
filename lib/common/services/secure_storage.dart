import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../widgets/respond.dart';

class Secure {
  static const String token = 'token';
  // static const String type = 'type';
  static String type() {
    String _type = 'type';
    return _type;
  }

  static token_write(Ref ref,
      {required Respond response, required String value}) {
    Respond _respons = response;
    ref.read(storageProvider).writeData(
        key: Secure.token, value: _respons.data['access_token'].toString());
    ref.read(storageProvider).writeData(key: Secure.type(), value: value);
  }
}

final storageProvider = Provider<MyStorage>((ref) => MyStorage(ref: ref));

class MyStorage {
  Ref? ref;
  MyStorage({this.ref});
  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> writeData({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  Future readData(String key) async {
    try {
      return await storage.read(key: key);
    } catch (e) {
      print("token error  $e");
      return null;
    }
  }

  Future readAll() async {
    var data = await storage.readAll();
    print("...readAll-Token {$data}");
    return data;
  }

  Future deleteData(String key) async {
    // ref!.refresh(storageProvider);
    await storage.delete(key: key);
  }

  Future deleteAll() async {
    var data = await storage.deleteAll();
    return data;
  }
}
