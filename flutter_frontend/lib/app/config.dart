import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static final String apiBaseUrl = dotenv.env['API_BASE_URL'] ?? "";
}
