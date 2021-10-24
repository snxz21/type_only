import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {

  @override
  void onCreate(bloc) {
    print('*** $bloc ***');
    print('Created: $bloc');
    print('--------------------');
    super.onCreate(bloc);
  }

  @override
  void onClose(bloc) {
    print('*** $bloc ***');
    print('Closed: $bloc');
    print('--------------------');
    super.onClose(bloc);
  }

  // @override
  // void onEvent(Bloc bloc, Object? event) {
  //   print('*** $bloc ***');
  //   print('onEvent: $event');
  //   print('--------------------');
  //   super.onEvent(bloc, event);
  // }

  @override
  void onChange(bloc, Change change) {
    print('*** $bloc ***');
    print('onChange: $change');
    print('--------------------');
    super.onChange(bloc, change);
  }

  // Cubit не попадает в onTransition
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('*** $bloc ***');
    print('onTransition: $transition');
    print('--------------------');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(bloc, Object error, StackTrace stackTrace) {
    print('*** $bloc ***');
    print('!!! Error: $error ');
    print('!!! StackTrace: $stackTrace');
    print('--------------------');
    super.onError(bloc, error, stackTrace);
  }


}