import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/services.dart';

abstract class AppDi {
  static Future<void> resolveAsyncDependencies() async {
  
  }

  static List<RepositoryProvider> repositories = [
    RepositoryProvider<MomService>.value(
      value: MomServiceImpl(),
    ),
  ];

  static List<BlocProvider> blocs = [];
}
