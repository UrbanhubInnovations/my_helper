import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../injection/injection.dart';
import '../auth/auth_provider.dart';

abstract class MultiProviders {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (_) => locator<AuthProvider>(),
    ),
  ];
}
