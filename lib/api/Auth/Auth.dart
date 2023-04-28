import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../api_urls.dart';


class Auth {
  static Future signUp({String? name, email, password}) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://3.110.75.42:3005/graphql'));
    request.body = '''{"query":"mutation{\\n  addUser(name: \\"$name\\",email: \\"$email\\",password: \\"$password\\"){\\n    id\\n    name\\n    email\\n  }\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print(result);
      return result;
    }
    else {
      print(response.reasonPhrase);
      return response.stream.bytesToString();
    }
  }

  static Future logIn({String? email, password}) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://3.110.75.42:3005/graphql'));
    request.body = '''{"query":"mutation{\\n  loginUser(email: \\"$email\\",password: \\"$password\\"){\\n    id\\n    name\\n    email\\n  }\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print(result);
      return result;
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
