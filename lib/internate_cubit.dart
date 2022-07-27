import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
enum InternateState {Initial,Lost,Gain}

class InternetCubit extends Cubit<InternateState>{
  Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;
  InternetCubit(): super(InternateState.Initial){
    connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        emit(InternateState.Gain);
      }
      else{
        emit(InternateState.Lost);
      }
    });
  }

@override
  Future<void> close(){
    connectivitySubscription?.cancel();
    return super.close();
}
}