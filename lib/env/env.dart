import 'package:envied/envied.dart';

@Envied(path: 'assets/.env')
abstract class Env {
  @EnviedField(varName: 'WEB_API_KEY')
  static final webApiKey = _Env.webApiKey;

  @EnviedField(varName: 'A_API_KEY')
  static final aApiKey = _Env.aApiKey;

  @EnviedField(varName: 'IOS_API_KEY')
  static final iosApiKey = _Env.iosApiKey;

  @EnviedField(varName: 'A_API_ID')
  static final aApiId = _Env.aApiId;

  @EnviedField(varName: 'W_API_ID')
  static final wApiId = _Env.wApiId;

  @EnviedField(varName: 'IOS_API_ID')
  static final iosApiId = _Env.iosApiId;
}
