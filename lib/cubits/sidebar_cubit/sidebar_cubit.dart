import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_states.dart';

class SidebarCubit extends Cubit<SidebarState> {
  SidebarCubit() : super(SidebarInitialState());

}