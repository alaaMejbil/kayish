import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureHelper{
  static  FlutterSecureStorage? _storage;
  static SecureHelper? _instance;
   SecureHelper._();

  static SecureHelper getInstance(){
    if(_instance==null){
      _storage= const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: IOSAccessibility.unlocked,
        ),
      );
      _instance = SecureHelper._();
    }

     return _instance!;
   }
  static  read(String  key)async{
    await _storage!.read(key: key);

   }

   static Future<void> write(String key,dynamic value)async {
    _storage!.write(key: key, value: value);
   }




}