import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';

import '../../example.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth <= 500;
        return Padding(
          padding: const EdgeInsets.all(kRegularPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (narrow) const Expanded(child: PreviousButton()),
              if (!narrow) const PreviousButton(),
              const SizedBox(width: kRegularPadding),
              if (narrow) Expanded(child: _buildForwardButton(context)),
              if (!narrow) _buildForwardButton(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildForwardButton(
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
        if (context.wizardController.isLastStep(index)) {
          return const FinishedButton();
        }
        return const NextButton();
      },
    );
  }
}
