class ApiVariables {
  /////////////
  ///General///
  /////////////
  final _scheme = 'http';
  final _host = '10.0.2.2';
  final _port = 8000;


  Uri _mainUri({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) {
    final uri = Uri(
      scheme: _scheme,
      host: _host,
      path: '/api/$path',
      port: _port,
      queryParameters: queryParameters,
    );
    return uri;
  }



  Uri login() => _mainUri(path: 'login/');


}
