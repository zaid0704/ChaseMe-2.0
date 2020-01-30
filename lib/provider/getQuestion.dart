import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
class GetQuestion with ChangeNotifier{

  Map<String , dynamic > question ;
  
  Future getQuestion ()async{
  http.Response response = await  http.get(
      Uri.parse(''));
  question = json.decode(response.body);

  }

  notifyListeners();
}