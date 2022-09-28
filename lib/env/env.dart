import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'WEATHER_URL')
  static final weatherUrl = _Env.weatherUrl;
  @EnviedField(varName: 'WEATHER_KEY')
  static final weatherKey = _Env.weatherKey;
  @EnviedField(varName: 'TIGHTLINES_API_URL')
  static final tightLinesKey = _Env.tightLinesKey;
  @EnviedField(varName: 'G_MAPS_KEY')
  static final gMapsKey = _Env.gMapsKey;
}
