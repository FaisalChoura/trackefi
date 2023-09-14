import 'package:expense_categoriser/core/domain/errors/error_object.dart';
import 'package:expense_categoriser/core/presentation/ui/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showDialogOnError(BuildContext context) => whenOrNull(error: (error, s) {
        showTrDialog(
            context,
            SizedBox(
              height: 200,
              width: 700,
              child: SingleChildScrollView(
                child: Column(children: [
                  Text(
                    ErrorObject.exceptionToErrorObjectMapper(
                            error.toString(), s)
                        .title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(ErrorObject.exceptionToErrorObjectMapper(
                          error.toString(), s)
                      .message)
                ]),
              ),
            ));
      });
}
