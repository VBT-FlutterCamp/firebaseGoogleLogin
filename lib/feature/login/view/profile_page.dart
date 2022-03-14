import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_login/feature/login/view/login_page.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;
  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('name:${user.displayName}'),
          Text('email:${user.email}'),
          Text('token:${user.uid}'),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                print('${FirebaseAuth.instance.currentUser.toString()}');
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('SIGN OUT'))
        ],
      )),
    );
  }
}
