import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ExecutionState { idle, loading, success, error }

// class Loading {
//   BuildContext context;

//   Loading.of(this.context);

//   Widget showGlobalLoading() {
//     return const Stack(
//       children: [
//         ModalBarrier(
//           dismissible: false,
//           color: Colors.black54,
//         ),
//         Center(
//           child: CircularProgressIndicator(),
//         ),
//       ],
//     );
//   }
// }

class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  LoadingProvider() {}

  void showLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void hideLoading() {
    _isLoading = false;
    notifyListeners();
  }
}

class LoadingScreen extends StatelessWidget {
  final Widget child;

  const LoadingScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Consumer<LoadingProvider>(
          builder: (context, loadingProvider, _) {
            if (loadingProvider.isLoading) {
              return const Stack(
                children: [
                  ModalBarrier(
                    dismissible: false,
                    color: Colors.black54,
                  ),
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
