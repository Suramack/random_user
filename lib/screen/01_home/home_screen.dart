import 'package:flutter/material.dart';
import 'package:random/core/model/random_user_response_model.dart';
import 'package:random/utils/strings/strings.dart';
import 'package:random/core/service/user_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RandomUserResponseModel? randomUserResponseModel;
  TextEditingController limitController = TextEditingController();
  Future<void> getRandomName() async {
    // randomUserResponseModel = await UserService.getRandomUser();
    // TODO
    if (limitController.text.isEmpty) {
      print('please enter a limit');
    } else {
      randomUserResponseModel =
          await UserService.getRandomUserList(int.parse(limitController.text));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          SizedBox(
            width: 200,
            child: TextField(
              controller: limitController,
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              getRandomName();
            },
            child: Text(Strings.submit),
          ),
          randomUserResponseModel == null
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: randomUserResponseModel!.results.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        Text(
                            randomUserResponseModel!.results[index].name.first),
                        Text(randomUserResponseModel!.results[index].name.last),
                      ],
                    ),
                  ),
                )
        ],
      ),
    ));
  }
}
