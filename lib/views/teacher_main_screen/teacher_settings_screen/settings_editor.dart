import "package:flutter/material.dart";
import "package:getteacher/common_widgets/submit_button.dart";
import "package:getteacher/net/teacher_settings/teacher_settings.dart";
import "package:getteacher/net/teacher_settings/teacher_settings_model.dart";

class SettingsEditor extends StatefulWidget {
  SettingsEditor({required this.settings});

  final TeacherSettingsModel settings;

  @override
  State<SettingsEditor> createState() => _SettingsEditorState();
}

class _SettingsEditorState extends State<SettingsEditor> {
  late TextEditingController _bioController;
  late TextEditingController _tariffController;
  final GlobalKey<FormState> formKey = GlobalKey();
  bool _bioEdited = false;
  bool _tariffEdited = false;

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController(text: widget.settings.bio);
    _tariffController =
        TextEditingController(text: widget.settings.tariffPerMinute.toString());
  }

  @override
  void dispose() {
    _bioController.dispose();
    _tariffController.dispose();
    super.dispose();
  }

  void _submit() {
    // Placeholder function for submitting data
    // Implement your save logic here
  }

  Widget _buildEditableField({
    final int minLines = 1,
    required final String label,
    required final TextEditingController controller,
    required final VoidCallback onSubmit,
    required final VoidCallback onChange,
    required final String? Function(String?) validate,
    required final bool isEdited,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            spacing: 5,
            children: <Widget>[
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
              if (isEdited)
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  onChanged: (final _) {
                    onChange();
                  },
                  minLines: minLines,
                  maxLines: minLines,
                  validator: validate,
                  controller: controller,
                ),
              ),
            ],
          ),
        ],
      );

  @override
  Widget build(final BuildContext context) => Form(
        autovalidateMode: AutovalidateMode.always,
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildEditableField(
                onChange: () {
                  setState(() {
                    _bioEdited = true;
                  });
                },
                minLines: 3,
                validate: (final _) => null,
                label: "Bio",
                controller: _bioController,
                onSubmit: _submit,
                isEdited: _bioEdited,
              ),
              const SizedBox(height: 16),
              _buildEditableField(
                onChange: () {
                  setState(() {
                    _tariffEdited = true;
                  });
                },
                validate: (final String? tariff) =>
                    double.tryParse(tariff!) == null
                        ? "Not a valid number"
                        : null,
                label: "Tariff Per Minute",
                controller: _tariffController,
                onSubmit: _submit,
                isEdited: _tariffEdited,
              ),
              const SizedBox(height: 32),
              const Spacer(),
              SubmitButton(
                submit: () async {
                  await setBio(_bioController.text);
                  await setCreditTarif(double.parse(_tariffController.text));
                  setState(() {
                    _submit();
                    _bioEdited = false;
                    _tariffEdited = false;
                  });
                },
                validate: () => formKey.currentState?.validate() ?? false,
              ),
            ],
          ),
        ),
      );
}
