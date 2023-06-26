import 'package:expense_categoriser/core/domain/errors/error_object.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showDialogOnError(BuildContext context) => whenOrNull(error: (error, _) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                padding: const EdgeInsets.all(16),
                height: 200,
                width: 400,
                child: Column(children: [
                  Text(
                    ErrorObject.exceptionToErrorObjectMapper(error.toString())
                        .title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      ErrorObject.exceptionToErrorObjectMapper(error.toString())
                          .message)
                ]),
              ),
            );
          },
        );
      });
}
