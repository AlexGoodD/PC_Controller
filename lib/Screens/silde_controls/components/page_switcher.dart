import 'package:flutter/material.dart';
import 'package:pc_controller_master/Screens/silde_controls/components/large_button.dart';
import 'package:pc_controller_master/settings/theme.dart';

class PageSwitcher extends StatelessWidget {
  const PageSwitcher({
    super.key,
    required this.nextSlideAction,
    required this.prevSlideAction
  });

  final VoidCallback nextSlideAction;
  final VoidCallback prevSlideAction;

  @override
  Widget build(BuildContext context) {

    final mediaQ = MediaQuery.of(context);
    final size = mediaQ.size;

    return Container(
      margin: const EdgeInsets.all(32),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width / 1),
          color: CustomTheme.bgTextField,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              LargeButton(
                icon: Icons.arrow_drop_up,
                onPressed: nextSlideAction,
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10)
              ),
              LargeButton(
                icon: Icons.arrow_drop_down,
                onPressed: prevSlideAction,
              )
            ],
          ),
        ),
      ),
    );
  }
}