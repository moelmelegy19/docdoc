import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_logger.dart';

/// Global BLoC Observer that logs all cubit/bloc lifecycle events to the console.
/// Registered in [main.dart] via [Bloc.observer = AppBlocObserver()].
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    AppLogger.bloc(
      'onCreate — ${bloc.runtimeType}',
      tag: 'BlocObserver',
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    AppLogger.bloc(
      'onChange — ${bloc.runtimeType}\n'
      '   └─ currentState: ${change.currentState.runtimeType}\n'
      '   └─ nextState   : ${change.nextState.runtimeType}',
      tag: 'BlocObserver',
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    AppLogger.bloc(
      'onTransition — ${bloc.runtimeType}\n'
      '   └─ event      : ${transition.event.runtimeType}\n'
      '   └─ currentState: ${transition.currentState.runtimeType}\n'
      '   └─ nextState   : ${transition.nextState.runtimeType}',
      tag: 'BlocObserver',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    AppLogger.error(
      'onError — ${bloc.runtimeType}',
      tag: 'BlocObserver',
      exception: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    AppLogger.bloc(
      'onClose — ${bloc.runtimeType}',
      tag: 'BlocObserver',
    );
  }
}
