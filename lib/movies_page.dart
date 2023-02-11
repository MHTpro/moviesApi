import 'package:flutter/material.dart';
import '../models/movie_models.dart';
import 'api/movie_api.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  Future<DataModel?>? response;

  @override
  void initState() {
    response = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Top Movies",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: response,
          builder: (BuildContext context, AsyncSnapshot<DataModel?> snapshot) {
            if (!(snapshot.hasData)) {
              return CircularProgressIndicator(
                backgroundColor: Colors.red,
                color: Colors.red[900],
                strokeWidth: 10.0,
              );
            }
            return response == null
                ? const Text(
                    "Slow Connection",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 550.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.red[900],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 150.0,
                                    child: Text(
                                      snapshot.data!.data![index]!.title
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 250.0,
                                    width: 200.0,
                                    child: Image.network(
                                      snapshot.data!.data![index]!.poster
                                          .toString(),
                                      alignment: Alignment.center,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Year: ${snapshot.data!.data![index]!.year}",
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Country: ${snapshot.data!.data![index]!.country}",
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Rate: ${snapshot.data!.data![index]!.imdbrating}",
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              screenShots(snapshot, index),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }

  screenShots(AsyncSnapshot<DataModel?> snapshot, int index) {
    int listLenght = snapshot.data!.data![index]!.images!.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        listLenght,
        (theImage) => SizedBox(
          height: 150.0,
          width: 120.0,
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.black87,
                    shape: const StadiumBorder(),
                    content: SizedBox(
                      height: 300.0,
                      width: 300.0,
                      child: Image.network(
                        snapshot.data!.data![index]!.images![theImage]!
                            .toString(),
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              );
            },
            child: Image.network(
              snapshot.data!.data![index]!.images![theImage]!.toString(),
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
