import 'package:flutter/material.dart';

// Import.
import 'package:flutter_boilerplate_project/src/bloc/state_bloc.dart';

// Export.
export 'package:flutter_boilerplate_project/src/bloc/state_bloc.dart';

class BlocProvider extends InheritedWidget {
  static BlocProvider? _instance;

  factory BlocProvider({ Key? key, required Widget child }) {
    _instance ??= BlocProvider._internal(key: key, child: child);

    return _instance!;
  }

  BlocProvider._internal({ Key? key, required Widget child }) : super(key: key, child: child);

  final StateBloc _stateBloc = StateBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static StateBloc stateBloc(BuildContext context) => context.dependOnInheritedWidgetOfExactType<BlocProvider>()!._stateBloc;
}