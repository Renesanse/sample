import "package:auth/auth.dart";
import "package:bolter_flutter/bolter_flutter.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:isolated_http_client/isolated_http_client.dart";
import "package:sample/features/auth/leading_screen.dart";
import "package:sample/features/auth/register/register_presenter.dart";
import "package:sample/features/auth/register/register_screen.dart";
import "package:sample/features/auth/summary/summary_presenter.dart";
import "package:sample/features/auth/summary/summary_screen.dart";
import "features/auth/selfie_screen.dart";

abstract class Routes {
  Routes._();

  static String leading = "leading";
  static String register = "register";
  static String selfie = "selfie";
  static String summary = "summary";
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Executor().warmUp(isolatesCount: 3);
  final client = HttpClient(log: true, timeout: const Duration(seconds: 20));

  final useCaseContainer = UseCaseContainer(
    // singleton for access from different routes, could be replaced to Scope
    singletonUseCases: {AuthUseCase: authUseCase(client, "")},
  );

  runApp(BolterProvider(
    useCaseContainer: useCaseContainer,
    child: GestureDetector(
      onTap: () {
        WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
      },
      child: Material(
        color: Colors.white,
        child: CupertinoApp(
          initialRoute: Routes.leading,
          theme: const CupertinoThemeData(
            barBackgroundColor: CupertinoColors.white,
            primaryColor: CupertinoColors.black,
          ),
          home: const LeadingScreen(),
          routes: {
            Routes.leading: (ctx) => const LeadingScreen(),
            Routes.register: (ctx) => PresenterProvider(
                  presenter: RegisterPresenter(BolterProvider.of(ctx).useCase<AuthUseCase>()),
                  child: const RegisterScreen(),
                ),
            Routes.selfie: (ctx) => const SelfieScreen(),
            Routes.summary: (ctx) => PresenterProvider(
              presenter: SummaryPresenter(BolterProvider.of(ctx).useCase<AuthUseCase>()),
              child: const SummaryScreen(),
            ),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  ));
}
