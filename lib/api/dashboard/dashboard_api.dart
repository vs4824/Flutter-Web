import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../api_urls.dart';
import 'package:example/controller/mobx.dart';


class Dashboard {
  static Future dashboardData({String? name, email, password}) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://3.110.75.42:3005/graphql'));
    request.body = '''{"query":"{\\n  providers{\\n    id\\n    name\\n    email\\n    desc\\n    service\\n  }\\n}","variables":{}}''';

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

  static Future addDashboardData({String? desc, service}) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://3.110.75.42:3005/graphql'));
    request.body = '''{"query":"mutation{\\n  addProvider(name:\\"${centralState.name}\\",email: \\"${centralState.email}\\",desc: \\"$desc\\",service:\\"$service\\"){\\n    id\\n    name\\n    email\\n    desc\\n    service\\n  }\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
