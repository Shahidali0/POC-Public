// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'intro_controller.dart';

class _IntroState {
  final bool isLoading;
  final int index;

  _IntroState({required this.isLoading, required this.index});

  _IntroState copyWith({
    bool? isLoading,
    int? index,
  }) {
    return _IntroState(
      isLoading: isLoading ?? this.isLoading,
      index: index ?? this.index,
    );
  }
}
