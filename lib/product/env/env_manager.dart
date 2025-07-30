import 'package:envied/envied.dart';

part 'env_manager.g.dart';

@Envied(
  obfuscate: true,
  path: String.fromEnvironment('ENV_FILE', defaultValue: 'assets/env/.env.dev'),
)
abstract class EnvManager {
  @EnviedField(varName: 'baseUrl', obfuscate: true)
  static String baseUrl = _EnvManager.baseUrl;
}
