import 'package:flutter/material.dart';

import '../../example.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({
    required this.provider,
    Key? key,
  }) : super(key: key);

  final StepTwoProvider provider;

  @override
  Widget build(
    BuildContext context,
  ) {
    return InputField(
      label: const Text(
        'Select an option',
      ),
      input: StreamBuilder<List<String>>(
        stream: provider.optionsStream,
        initialData: provider.options,
        builder: (context, snapshot) {
          final options = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
              mainAxisSpacing: kRegularPadding,
              crossAxisSpacing: kRegularPadding,
            ),
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options[index];
              return StreamBuilder<String?>(
                stream: provider.selectionStream,
                initialData: provider.selection,
                builder: (context, snapshot) {
                  final selection = snapshot.data;
                  final isSelection = option == selection;
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isSelection
                            ? Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.5)
                            : Colors.grey.shade200,
                      ),
                      child: Center(
                        child: Text(option),
                      ),
                    ),
                    onTap: () => provider.select(option),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
