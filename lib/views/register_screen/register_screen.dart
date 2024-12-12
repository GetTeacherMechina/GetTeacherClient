import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:getteacher/common_widgets/submit_button.dart";
import "package:getteacher/views/register_screen/register_model.dart";
import "package:getteacher/views/register_screen/user_role_input.dart";

const int studnetIndex = 0;
const int teacherIndex = 1;

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterModel model = const RegisterModel();

  late final TextEditingController emailController =
      TextEditingController(text: model.email);
  late final TextEditingController nameController =
      TextEditingController(text: model.fullName);

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Row(
            children: <Widget>[
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    const Spacer(
                      flex: 1,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: "Full name",
                      ),
                      onChanged: (final String value) {
                        model = model.copyWith(fullName: () => value);
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: "Email"),
                      controller: emailController,
                      onChanged: (final String value) {
                        setState(() {
                          model = model.copyWith(email: () => value);
                        });
                      },
                      validator: (final String? email) =>
                          email != null && EmailValidator.validate(email)
                              ? null
                              : "Invalid Email",
                    ),
                    ToggleButtons(
                      children: const <Widget>[
                        Tooltip(message: "Teacher", child: Icon(Icons.school)),
                        Tooltip(message: "Student", child: Icon(Icons.book)),
                      ],
                      isSelected: <bool>[
                        model.role.isTeacher(),
                        model.role.isStudent(),
                      ],
                      onPressed: (final int index) {
                        setState(() {
                          model = model.copyWith(
                            role: () => switch (model.role) {
                              Teacher() => index == teacherIndex
                                  ? StudentAndTeacher(
                                      const Student.empty(),
                                      model.role as Teacher,
                                    )
                                  : model.role,
                              Student() => index == studnetIndex
                                  ? StudentAndTeacher(
                                      model.role as Student,
                                      const Teacher.empty(),
                                    )
                                  : model.role,
                              StudentAndTeacher(
                                student: final Student student,
                                teacher: final Teacher teacher
                              ) =>
                                index == studnetIndex ? student : teacher
                            },
                          );
                        });
                      },
                    ),
                    UserRoleInput(
                      role: model.role,
                      onRoleChanged: (final UserRole role) {
                        setState(() {
                          model = model.copyWith(role: () => role);
                        });
                      },
                    ),
                    const Spacer(
                      flex: 4,
                    ),
                    SubmitButton(
                      validate: () => _formKey.currentState!.validate(),
                      submit: () =>
                          Future<void>.delayed(const Duration(seconds: 3)),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      );
}
