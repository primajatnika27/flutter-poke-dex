class ApiConfig {
  ApiConfig._();

  static const String baseUrl = 'https://pokeapi.co/api/v2/';
  static const Duration receiveTimeout = Duration(milliseconds: 15000);
  static const Duration connectionTimeout = Duration(milliseconds: 15000);
  static const  headers = {'Content-Type': 'application/json'};
}