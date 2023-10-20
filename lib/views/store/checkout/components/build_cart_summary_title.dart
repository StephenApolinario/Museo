import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';

class BuildCartSummaryTitle extends StatelessWidget {
  const BuildCartSummaryTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: mainBlue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Center(
                  child: Text(
                    // TODO:  This text must be provided by L10N
                    'Resumo do pedido',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
