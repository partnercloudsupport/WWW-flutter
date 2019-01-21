import 'package:redux/redux.dart';
import 'package:what_when_where/redux/app/state.dart';
import 'package:what_when_where/redux/timer/middleware.dart';

class AppMiddleware {
  static final middleware = List<Middleware<AppState>>()
    ..addAll(TimerMiddleware.middleware);
}