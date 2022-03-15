import 'package:http/http.dart' as http;

import '../model/user_model.dart';

class UserService {
  Future getUserModel(int deger) async {
    var response = await http.get(Uri.parse('https://emailandapi-default-rtdb.firebaseio.com/$deger.json'));

    return denemeModelFromJson(response.body);
  }
}
