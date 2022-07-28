import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/ApiThirdModel.dart';
import '../models/ApitwoModel.dart';
import '../models/homemodel.dart';

var dio = Dio();

Future<List<TrackList>> apihome() async {
  final response = await dio.get(
      'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7');

  final data = json.decode(response.data) as Map<String, dynamic>;
  ;
  Musiclist musiclist = Musiclist.fromJson(data);
  //print(musiclist.message!.body!.trackList!.length);
  return musiclist.message!.body!.trackList!;
}

Future<Tracks?> apisecond(int tid) async {
  var dio = Dio();

  final response = await dio.get(
      'https://api.musixmatch.com/ws/1.1/track.get?track_id=$tid&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7');
  if (response.statusCode == 200) {
    //print(response.data);
    final data = json.decode(response.data) as Map<String, dynamic>;
    ;
    ApiSecond apiSecond = ApiSecond.fromJson(data);
    return apiSecond.message.body.track;
  } else {
    print(response.data);
  }
}

Future<Lyrics?> apiThird(int tid) async {
  var dio = Dio();

  final response = await dio.get(
      'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$tid&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7');
  if (response.statusCode == 200) {
    //print(response.data);
    final data = json.decode(response.data) as Map<String, dynamic>;
    ;
    ApiThird apiSecond = ApiThird.fromJson(data);
    return apiSecond.message.body.lyrics;
  } else {
    print(response.data);
  }
}
