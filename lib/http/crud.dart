import 'package:http/http.dart' as http;
import 'dart:convert';

class Crud
{
  getData(String uri) async {
    try{
      var response=await http.get(Uri.parse(uri));

      if(response.statusCode==200)
        {
          var body=await jsonDecode(response.body);
          return body;
        }
      else
        print('there is an error');

    }
    catch(e)
    {
      print(e);
    };


  }



 postData(String uri,Map data) async {
    try{
      var response=await http.post(Uri.parse(uri),body: data);

      if(response.statusCode==200)
      {
        var body=await jsonDecode(response.body);
        return body;
      }
      else
        print('there is an error');

    }
    catch(e)
    {
      print(e);
    };


  }
}