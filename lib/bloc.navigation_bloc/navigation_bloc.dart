import 'package:bloc/bloc.dart';
import 'package:myapp/Pages/homepage.dart';
import 'package:myapp/Pages/myinfopage.dart';
import 'package:myapp/SplashScreen/splash_screen.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyInfoClickedEvent,
  // MyOrdersClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.MyInfoClickedEvent:
        yield MyInfoPage();
        break;
      /*
      case NavigationEvents.MyAccountClickedEvent:
        yield MyAccountsPage();
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        yield MyOrdersPage();
        break;*/
    }
  }
}
