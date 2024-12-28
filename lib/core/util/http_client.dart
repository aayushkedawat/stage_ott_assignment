import 'package:http/http.dart' as http;
import 'package:stage_ott_assignment/core/constants/constants.dart';

class UserAgentClient extends http.BaseClient {
  final http.Client _inner;

  UserAgentClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = 'Bearer ${Constants.token}';
    return _inner.send(request);
  }
}
