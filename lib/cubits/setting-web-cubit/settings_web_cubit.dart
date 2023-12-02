import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/setting-web-cubit/setting_web_states.dart';

class SettingsWebCubit extends Cubit<SettingsWeb> {
  SettingsWebCubit() : super(SettingsWebInitialState());
  void toggleMenu(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        emit(SettingsWebAccountInfo());
        break;
      case 1:
        emit(SettingsWebChangePassword());
        break;
      case 2:
        emit(SettingsWebVerifyPassword());
        break;
      default:
        emit(SettingsWebAccountInfo());
    }
  }
}
