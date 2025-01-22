import "package:flutter/material.dart";
import "package:getteacher/theme/theme.dart";
import "package:progress_state_button/iconed_button.dart";
import "package:progress_state_button/progress_button.dart";

class SubmitButton extends StatefulWidget {
  SubmitButton({
    required this.validate,
    required this.submit,
  });
  final bool Function() validate;
  final Future<void> Function() submit;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  ButtonState _state = ButtonState.idle;
  String failedMessage = "Failed";
  @override
  Widget build(final BuildContext context) => ProgressButton.icon(
        iconedButtons: <ButtonState, IconedButton>{
          ButtonState.idle: const IconedButton(
            text: "Submit",
            icon: Icon(Icons.send, color: Colors.white),
            color: AppTheme.primaryColor,
          ),
          ButtonState.loading: IconedButton(
            text: "Loading",
            color: Colors.deepPurple.shade200,
          ),
          ButtonState.fail: IconedButton(
            text: failedMessage,
            icon: const Icon(Icons.cancel, color: Colors.white),
            color: Colors.red.shade400,
          ),
          ButtonState.success: IconedButton(
            text: "Success",
            icon: const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            color: Colors.green.shade400,
          ),
        },
        onPressed: () async {
          if (!widget.validate()) {
            setState(() {
              failedMessage = "Fields are invalid";
              _state = ButtonState.fail;
            });
            Future<void>.delayed(const Duration(seconds: 5), () {
              if (mounted) {
                setState(() {
                  failedMessage = "Failed";
                  _state = ButtonState.idle;
                });
              }
            });
            return;
          }
          if (_state == ButtonState.loading) {
            return;
          }
          setState(() {
            _state = ButtonState.loading;
          });

          try {
            await widget.submit();
            if (mounted) {
              setState(() {
                _state = ButtonState.success;
              });
            }
          } on Exception catch (_) {
            if (mounted) {
              setState(() {
                _state = ButtonState.fail;
              });
            }
          }

          Future<void>.delayed(const Duration(seconds: 3), () {
            if (mounted) {
              setState(() {
                _state = ButtonState.idle;
              });
            }
          });
        },
        state: _state,
        radius: 30.0,
        progressIndicator: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      );
}
