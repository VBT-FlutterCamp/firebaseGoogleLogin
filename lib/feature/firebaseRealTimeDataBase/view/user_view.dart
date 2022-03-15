import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../service/user_service.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  bool _isLoading = false;
  List<DenemeModel> userList = [];
  void changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> getData() async {
    changeLoading();
    for (var i = 0; i < 8; i++) {
      userList.add(await UserService().getUserModel(i));
    }
    changeLoading();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: userList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(userList[index].body.toString()),
                );
              },
            ),
    );
  }
}
