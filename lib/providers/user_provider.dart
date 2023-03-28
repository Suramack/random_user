import 'package:flutter/material.dart';
import 'package:random/core/model/random_user_response_model.dart';
import 'package:random/core/service/user_service.dart';

class UserProvider extends ChangeNotifier {
  RandomUserResponseModel? randomUserResponseModel;

  getRandomName(int value) async {
    randomUserResponseModel = await UserService.getRandomUserList(value);
    notifyListeners();
  }
}
