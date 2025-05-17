
import 'dart:convert';

import 'package:task/qoute/quote.dart';
import 'package:http/http.dart' as http;
Future <List <Quote>> fetchQuote ()async {
  
 final response = await http.get(Uri.parse("https://api.api-ninjas.com/v1/quotes"),

   headers: {
     'X-Api-Key': '+e4S++3BYYbsf31mFJXc9g==jgHjFM1SAvhVdY2E'
   },

 );
  if (response.statusCode == 200){

    List <dynamic> data = jsonDecode(response.body);
    return data.map((json)=> Quote.fromJson(json )).toList();
  }
  throw Exception("Failed to load data");
}