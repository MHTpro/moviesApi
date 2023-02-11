import 'dart:convert';
import 'package:http/http.dart' as httpmethod;
import '../models/movie_models.dart';

Future<DataModel> getData() async {
  final response = await httpmethod.get(
    Uri.https("moviesapi.ir", "/api/v1/movies"),
  );

  if (response.statusCode == 200) {
    return DataModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Can't show movies!!!");
  }
}

// Future<List<MovieModel>> getAll() async {
//   final response = await httpmethod.get(
//     Uri.https("moviesapi.ir", "/api/v1/movies"),
//   );

//   if (response.statusCode == 200) {
//     List<MovieModel> myList;
//     myList = List<MovieModel>.from(
//       jsonDecode(response.body).map(
//         (v) => MovieModel.fromJson(v),
//       ),
//     );
//     return myList;
//   } else {
//     throw Exception("Can't show movies!!!");
//   }
// }
