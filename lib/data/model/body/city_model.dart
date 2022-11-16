import 'dart:convert';
import 'package:http/http.dart' as http;

class CityModel {
  int id;
  String city;

  CityModel(
      {this.id,
        this.city,
      });

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.city;
    return data;
  }
}


Future<dynamic> _getCities() async {
  String apiKey = 'https://php.amyz.tech/api/v1/customer/address/list';
  http.Response response = await http.get(Uri.parse(Uri.encodeFull(apiKey)));
  Map<dynamic,dynamic> data = jsonDecode(response.body);
  print("$data");
}
