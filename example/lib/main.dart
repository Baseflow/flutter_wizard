import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:provider/provider.dart';

import 'example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      title: 'Flutter Wizard Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.blue,
          onPrimary: Colors.white,
          secondary: Colors.orange,
          onSecondary: Colors.white,
          surface: Colors.grey.shade100,
          onSurface: Colors.grey.shade700,
          background: Colors.white,
          onBackground: Colors.grey.shade700,
          error: Colors.redAccent,
          onError: Colors.white,
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          linearTrackColor: Colors.orange.shade100,
          color: Colors.orange,
        ),
      ),
      home: ProviderExamplePage.provider(),
    );
  }
}

class ProviderExamplePage extends StatelessWidget {
  const ProviderExamplePage._({Key? key}) : super(key: key);

  static Provider provider({Key? key}) {
    return Provider<ProviderExamplePageProvider>(
      create: (_) => ProviderExamplePageProvider(),
      dispose: (_, provider) => provider.dispose(),
      child: ProviderExamplePage._(
        key: key,
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final provider = Provider.of<ProviderExamplePageProvider>(
      context,
    );
    return DefaultWizardController(
      stepControllers: [
        WizardStepController(
          step: provider.stepOneProvider,
        ),
        WizardStepController(
          step: provider.stepTwoProvider,
          isNextEnabled: false,
        ),
        WizardStepController(
          step: provider.stepThreeProvider,
        ),
      ],
      // Wrapping with a builder so the context contains the [WizardController]
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: StreamBuilder<int>(
                stream: context.wizardController.indexStream,
                initialData: context.wizardController.index,
                builder: (context, snapshot) {
                  return Text("Wizard Example - Step ${snapshot.data! + 1}");
                },
              ),
            ),
            body: WizardEventListener(
              listener: (context, event) {
                debugPrint('### ${event.runtimeType} received');
                if (event is WizardForcedGoBackToEvent) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Step ${event.toIndex + 2} got disabled so the wizard is moving back to step ${event.toIndex + 1}.',
                    ),
                    dismissDirection: DismissDirection.horizontal,
                  ));
                }
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      _buildProgressIndicator(
                        context,
                      ),
                      Expanded(
                        child: _buildWizard(
                          context,
                          provider: provider,
                          constraints: constraints,
                        ),
                      ),
                      const ActionBar(),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWizard(
    BuildContext context, {
    required ProviderExamplePageProvider provider,
    required BoxConstraints constraints,
  }) {
    final wizard = Wizard(
      stepBuilder: (context, state) {
        if (state is StepOneProvider) {
          return StepOne(
            provider: state,
          );
        }
        if (state is StepTwoProvider) {
          return StepTwo(
            provider: state,
          );
        }
        if (state is StepThreeProvider) {
          return StepThree(
            provider: state,
          );
        }
        return Container();
      },
    );
    final narrow = constraints.maxWidth <= 500;
    if (narrow) {
      return wizard;
    }
    return Row(
      children: [
        const SizedBox(
          width: 200,
          child: StepsOverview(),
        ),
        Expanded(
          child: wizard,
        ),
      ],
    );
  }

  Widget _buildProgressIndicator(
    BuildContext context,
  ) {
    return StreamBuilder<int>(
      stream: context.wizardController.indexStream,
      initialData: context.wizardController.index,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return const SizedBox.shrink();
        }
        final index = snapshot.data!;
        return StepsProgressIndicator(
          count: context.wizardController.stepCount,
          index: index,
        );
      },
    );
  }
}

class ProviderExamplePageProvider {
  ProviderExamplePageProvider()
      : stepOneProvider = StepOneProvider(),
        stepTwoProvider = StepTwoProvider(),
        stepThreeProvider = StepThreeProvider();

  final StepOneProvider stepOneProvider;
  final StepTwoProvider stepTwoProvider;
  final StepThreeProvider stepThreeProvider;

  Future<void> reportIssue() async {
    debugPrint('Finished!');
  }

  Future<void> dispose() async {
    stepOneProvider.dispose();
    stepTwoProvider.dispose();
  }
}
