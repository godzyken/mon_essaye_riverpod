import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'assets/.env')
abstract class Env {
  @EnviedField(varName: 'W_API_KEY')
  static final wApiKey = _Env.wApiKey;

  @EnviedField(varName: 'A_API_KEY')
  static final aApiKey = _Env.aApiKey;

  @EnviedField(varName: 'IOS_API_KEY')
  static final iosApiKey = _Env.iosApiKey;

  @EnviedField(varName: 'A_ID_KEY')
  static final aIdKey = _Env.aIdKey;

  @EnviedField(varName: 'W_ID_KEY')
  static final wIdKey = _Env.wIdKey;

  @EnviedField(varName: 'IOS_ID_KEY')
  static final iosIdKey = _Env.iosIdKey;
}
