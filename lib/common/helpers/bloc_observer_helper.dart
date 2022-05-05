import 'package:flutter_bloc/flutter_bloc.dart';

class BlocObserverHelper extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print(bloc.toString() + " " + event.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    print(bloc.toString() + " " + error.toString());
    print(stacktrace.toString());
    super.onError(bloc, error, stacktrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(bloc.toString() + " " + transition.toString());
    super.onTransition(bloc, transition);
  }
}