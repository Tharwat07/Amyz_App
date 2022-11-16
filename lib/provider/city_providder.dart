
import 'package:amyz_user_app/data/repository/city_repo.dart';
import 'package:flutter/material.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/category.dart';
import '../data/repository/category_repo.dart';
import '../helper/api_checker.dart';

class CityProvider extends ChangeNotifier {
  final CityRepo cityRepo;

  CityProvider({@required this.cityRepo});


  List<Category> _cityList = [];
  int _citySelectedIndex;

  List<Category> get categoryList => _cityList;
  int get citySelectedIndex => _citySelectedIndex;

  Future<void> getCityList(bool reload, BuildContext context) async {
    if (_cityList.length == 0 || reload) {
      ApiResponse apiResponse = await cityRepo.getCityList();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        _cityList.clear();
        apiResponse.response.data.forEach((category) => _cityList.add(Category.fromJson(category)));
        _citySelectedIndex = 0;
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }

  void changeSelectedIndex(int selectedIndex) {
    _citySelectedIndex = selectedIndex;
    notifyListeners();
  }
}