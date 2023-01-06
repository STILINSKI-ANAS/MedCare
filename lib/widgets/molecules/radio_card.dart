import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RadioCard extends StatelessWidget {
  const RadioCard(
      {Key? key, this.onTap, required this.active, required this.text})
      : super(key: key);
  final bool active;
  final VoidCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Container(
          alignment: Alignment.center,
          height: 44,
          decoration: BoxDecoration(
            border: Border.all(
                color: (active)
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : Theme.of(context).colorScheme.secondary,
                width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.clock,
                size: 18,
                color: (active)
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).colorScheme.onSurface.withOpacity(.33),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(text,
                  style: TextStyle(
                    color: (active)
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(context).colorScheme.onSurface.withOpacity(.33),
                  )),
            ],
          ),
        ));
  }
}
