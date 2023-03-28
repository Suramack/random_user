import 'package:random/core/model/random_user_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:random/core/config/config.dart';
import 'package:random/utils/utils/utils.dart';

class UserService {
  static Future<RandomUserResponseModel> getRandomUser() async {
    var url = Uri.parse(ApiUrl.url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return randomUserResponseModelFromJson(response.body);
    } else {
      Utils.handleException(response);
      throw response.body;
    }
  }

  static Future<RandomUserResponseModel> getRandomUserList(int limit) async {
    var url = Uri.parse('${ApiUrl.url}?results=$limit');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return randomUserResponseModelFromJson(response.body);
    } else {
      Utils.handleException(response);
      throw response.body;
    }
  }
}
