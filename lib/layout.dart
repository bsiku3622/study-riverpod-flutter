import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rivorpod/home.dart';
import 'package:rivorpod/states/counter.dart';
import 'package:rivorpod/states/sign_mode.dart';

class MyLayout extends ConsumerWidget {
  MyLayout({
    super.key,
    required this.count,
    required this.counterProvider,
  });

  final Object? count;
  final StateNotifierProvider<Counter, Object?> counterProvider;
  final isRegisterModeProvider =
      StateNotifierProvider((ref) => IsRegisterMode());

  static const List<Widget> _screens = <Widget>[
    Text("HomeScreen()"),
    Text("ClassroomScreen()"),
    Text("FeedScreen()"),
    Text("MessageScreen()"),
    Text("MenuScreen()"),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRegisterMode = ref.watch(isRegisterModeProvider);
    return Center(
      child: Column(
        children: [
          TextButton(
            child: const Text("증가"),
            onPressed: () => ref.watch(counterProvider.notifier).increase(),
          ),
          TextButton(
            child: const Text("감소"),
            onPressed: () => ref.watch(counterProvider.notifier).decrease(),
          ),
          _screens.elementAt(int.parse(count.toString())),
          isRegisterMode.toString() == 'true'
              ? RegisterPage(isRegisterModeProvider: isRegisterModeProvider)
              : LoginPage(isRegisterModeProvider: isRegisterModeProvider),
        ],
      ),
    );
  }
}

class RegisterPage extends ConsumerWidget {
  const RegisterPage({
    super.key,
    required this.isRegisterModeProvider,
  });

  final StateNotifierProvider<IsRegisterMode, Object?> isRegisterModeProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      child: const Text("False"),
      onPressed: () => ref.watch(isRegisterModeProvider.notifier).makeFalse(),
    );
  }
}

class LoginPage extends ConsumerWidget {
  const LoginPage({
    super.key,
    required this.isRegisterModeProvider,
  });

  final StateNotifierProvider<IsRegisterMode, Object?> isRegisterModeProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      child: const Text("True"),
      onPressed: () => ref.watch(isRegisterModeProvider.notifier).makeTrue(),
    );
  }
}
