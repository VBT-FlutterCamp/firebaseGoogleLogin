import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../product/utils/firestore_functions.dart';

class FirestoreView extends StatefulWidget {
  const FirestoreView({Key? key}) : super(key: key);

  @override
  State<FirestoreView> createState() => _FirestoreViewState();
}

class _FirestoreViewState extends State<FirestoreView> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('datas');
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            FutureBuilder<DocumentSnapshot>(
                future: users.doc('d4tzmbqXzXn06dLPqiBy').get(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('i have error');
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data = snapshot.data?.data() as Map<String, dynamic>;

                    return Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Center(
                        child: Column(
                          children: [
                            Text(data['surname']),
                            Text(data['name']),
                            Text(data['bknınDovdukleri'][0].toString()),
                            Text(data['student']['name'].toString()),
                            Text(data['student']['surname'].toString())
                          ],
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })),
            TextButton(
                onPressed: () {
                  FirestoreFunctions().deleteData();
                },
                child: Text('delete')),
            TextButton(
                onPressed: () {
                  FirestoreFunctions().addWithAdd();
                },
                child: Text('add')),
            TextButton(
                onPressed: () {
                  FirestoreFunctions().addWithSet();
                },
                child: Text('set')),
            TextButton(
                onPressed: () {
                  FirestoreFunctions().getData();
                },
                child: Text('get')),
            TextButton(
                onPressed: () {
                  FirestoreFunctions().updateData();
                },
                child: Text('update')),
          ],
        ),
      ),
    );
  }
}
