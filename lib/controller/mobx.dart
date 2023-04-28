import 'package:mobx/mobx.dart';
part 'mobx.g.dart';

class CentralState = CentralStateBase with _$CentralState;

abstract class CentralStateBase with Store {
  @observable
  int index = 0;  // Bottom bar index

  String? email, token, name, id;

  List files = [];
}

//instance of a central state
final centralState = CentralState();

///RUN TO REFRESH
///if you update state management variable
///flutter packages pub run build_runner build
///OR
///flutter packages pub run build_runner build --delete-conflicting-outputs
