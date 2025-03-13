import 'package:cricket_poc/lib_exports.dart';

final postServiceControllerPr =
    StateNotifierProvider<PostServiceController, bool>(
  (ref) => PostServiceController(),
);

class PostServiceController extends StateNotifier<bool> {
  PostServiceController() : super(false);
}
