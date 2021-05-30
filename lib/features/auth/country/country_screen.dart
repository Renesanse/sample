import "package:auth/auth.dart";
import "package:bolter_flutter/bolter_flutter.dart";
import "package:cupertino_list_tile/cupertino_list_tile.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:sample/features/auth/country/country_presenter.dart";
import "package:sample/widgets/async_fade_in.dart";
import "package:sample/widgets/sample_button.dart";

Future<String?> selectCountry(BuildContext context) {
  return Navigator.of(context).push<String>(
    PageRouteBuilder(
      pageBuilder: (ctx, a, sa) {
        final height = MediaQuery.of(ctx).viewInsets.bottom;
        return CupertinoFullscreenDialogTransition(
          primaryRouteAnimation: a,
          secondaryRouteAnimation: sa,
          linearTransition: false,
          child: PresenterProvider(
            presenter: CountryPresenter(BolterProvider.of(context).useCase<AuthUseCase>()),
            child: AnimatedContainer(
              curve: Curves.decelerate,
              padding: EdgeInsets.only(bottom: height < 0 ? 0 : height),
              duration: height == 0.0 ? const Duration(milliseconds: 150) : const Duration(milliseconds: 300),
              child: const CountryScreen(),
            ),
          ),
        );
      },
    ),
  );
}

class CountryScreen extends StatefulWidget {
  const CountryScreen({Key? key}) : super(key: key);

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  @override
  Widget build(BuildContext context) {
    final presenter = context.presenter<CountryPresenter>();
    return Material(
      color: CupertinoColors.white,
      child: SafeArea(
        child: AsyncFadeIn<void>(
          errorBuilder: (e) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(CupertinoIcons.wifi_exclamationmark),
                  const SizedBox(height: 16),
                  SampleButton(
                    horizontalPadding: 16,
                    text: "Try again",
                    onPressed: () {
                      setState(() {});
                    },
                  )
                ],
              ),
            );
          },
          dataBuilder: (_) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          onChanged: (value) => presenter.filter(value),
                          clearButtonMode: OverlayVisibilityMode.editing,
                          placeholder: "Search",
                          textInputAction: TextInputAction.search,
                        ),
                      ),
                      const SizedBox(width: 16),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: ValueStreamBuilder<Iterable<Country>>(
                  valueStream: presenter.countries,
                  builder: (ctx, value) {
                    return ListView.builder(
                      itemBuilder: (ctx, index) {
                        final name = value.elementAt(index).name;
                        return CupertinoListTile(
                          key: ValueKey(name),
                          title: Text(name),
                          onTap: () => Navigator.of(ctx).pop(name),
                        );
                      },
                      itemCount: value.length,
                    );
                  },
                ))
              ],
            );
          },
          future: presenter.setup(),
        ),
      ),
    );
  }
}
