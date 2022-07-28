import 'package:flutter/material.dart';
import 'package:flutter_demo/models/homemodel.dart';
import 'apicall.dart';
import 'secondscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TrackList>?>(
      future: apihome(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisExtent: MediaQuery.of(context).size.height / 3,
                // crossAxisSpacing: 20,
                // mainAxisSpacing: 20
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final data = snapshot.data![index].track!;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SecondScreen(
                                  id: data.trackId!,
                                )));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          'assets/book.jpg',
                          height: 170,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          data.albumName!,
                          style: TextStyle(
                            overflow: TextOverflow.fade,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(data.artistName!.toString()),
                      ],
                    ),
                  ),
                );
              });
        } else {
          return CircularProgressIndicator(
            color: Colors.black,
          );
        }
      },
    );
  }
}
