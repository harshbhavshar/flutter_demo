import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../internate_cubit.dart';
import '../models/ApiThirdModel.dart';
import '../models/ApitwoModel.dart';
import 'apicall.dart';

class SecondScreen extends StatefulWidget {
  final int id;

  const SecondScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  txt(String data, Color color, double fsize, FontWeight fweigth) {
    return Flexible(
      child: Text(
        data,
        style: TextStyle(
            color: color,
            fontSize: fsize,
            fontWeight: fweigth,
            overflow: TextOverflow.fade),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Details"),
        centerTitle: true,
        elevation: 0.0,
        foregroundColor: Colors.white,
        surfaceTintColor: Color(0xff574396),
        backgroundColor: Color(0xff574396),
      ),
      body: BlocConsumer<InternetCubit, InternateState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state == InternateState.Gain) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder<Tracks?>(
                    future: apisecond(widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return Container(
                          height: size.height / 1.8,
                          width: size.width,
                          color: Color(0xff574396),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/book.jpg",
                                height: 220,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              txt(data.artistName, Colors.white, 20,
                                  FontWeight.bold),
                              SizedBox(
                                height: 10,
                              ),
                              txt(data.albumName, Colors.white, 20,
                                  FontWeight.bold),
                              SizedBox(
                                height: 30,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: size.width / 2,
                                      child: Column(
                                        children: [
                                          txt(data.trackName, Colors.white, 20,
                                              FontWeight.bold),
                                          txt("TrackName", Colors.white60, 15,
                                              FontWeight.bold),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 20,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: size.width / 2.3,
                                      child: Column(
                                        children: [
                                          txt(
                                              data.trackRating.toString(),
                                              Colors.white,
                                              20,
                                              FontWeight.bold),
                                          txt("Rating", Colors.white60, 15,
                                              FontWeight.bold),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  FutureBuilder<Lyrics?>(
                    future: apiThird(widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            //txt("Lyrics", Colors.black, 30, FontWeight.bold),

                            Text(
                              "Lyrics",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(snapshot.data!.lyricsBody),
                          ],
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  )
                ],
              ),
            );
          }
           else if(state == InternateState.Lost) {
            return Center(
              child: Text('Check Your Connection'),
            );
          }
           else{
             return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
