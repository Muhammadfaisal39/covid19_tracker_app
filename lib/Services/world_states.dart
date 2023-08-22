import 'dart:convert';
import 'package:covid19_tracker_app/utilities/appurls.dart';
import 'package:http/http.dart' as http;
import '../Modals/WorldStatesModal.dart';

class WorldStatesData {

  Future<WorldStatesModal> getWorldStates() async {
    final response = await http.get(
        Uri.parse('https://disease.sh/v3/covid-19/all'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return WorldStatesModal.fromJson(data);
    } else {
      return WorldStatesModal.fromJson(data);
    }
  }

  Future<List<dynamic>> getCountries() async {

    final response = await http.get(
        Uri.parse('https://disease.sh/v3/covid-19/countries'));
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      return data;
    }
  }

}