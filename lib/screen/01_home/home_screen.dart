import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random/core/model/random_user_response_model.dart';
import 'package:random/providers/user_provider.dart';
import 'package:random/utils/strings/strings.dart';
import 'package:random/core/service/user_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.initState();
  }

  late UserProvider userProvider;
  TextEditingController limitController = TextEditingController();
  Future<void> getRandomName() async {
    // randomUserResponseModel = await UserService.getRandomUser();
    // TODO
    if (limitController.text.isEmpty) {
      print('please enter a limit');
    } else {
      userProvider.getRandomName(int.parse(limitController.text));
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
          const SizedBox(height: 100),
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
          // userProvider.isloading

          Consumer<UserProvider>(builder: (context, userProvider, child) {
            return userProvider.randomUserResponseModel == null
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount:
                          userProvider.randomUserResponseModel!.results.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          Text(userProvider.randomUserResponseModel!
                              .results[index].name.first),
                          Text(userProvider.randomUserResponseModel!
                              .results[index].name.last),
                        ],
                      ),
                    ),
                  );
          })
        ],
      ),
    ));
  }
}
