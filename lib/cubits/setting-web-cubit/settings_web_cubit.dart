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
      case 3:
        emit(SettingsWebChangeChoose());
        break;
      case 4:
        emit(SettingsWebChangeEmail());
        break;
         case 5:
        emit(SettingsWebChangeUsername());
        break;
      default:
        emit(SettingsWebAccountInfo());
    }
  }
}
