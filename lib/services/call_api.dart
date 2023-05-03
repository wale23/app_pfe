import 'package:app_pfe/services/api_constants.dart';
import 'package:http/http.dart' as http;

class CallApi {
  getData(url) async {
    var fullUrl = ApiConstants.baseUrl + url;
    return await http.get(Uri.parse(fullUrl));
  }

  postData(url, data) async {
    var fullUrl = ApiConstants.baseUrl + url;
    return await http.post(Uri.parse(fullUrl), body: data, headers: getHeaders());
  }

  getHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Connection": "Keep-Alive",
      };
}
