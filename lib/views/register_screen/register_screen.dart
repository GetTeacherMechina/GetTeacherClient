import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:getteacher/views/register_screen/register_model.dart";
import "package:getteacher/views/register_screen/user_role_input.dart";

const int studnetIndex = 1;
const int teacherIndex = 0;

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
                        Icon(Icons.school),
                        Icon(Icons.book),
                      ],
                      isSelected: <bool>[
                        model.role.isTeacher(),
                        model.role.isStudent(),
                      ],
                      onPressed: (final int index) {
                        setState(() {
                          model = model.copyWith(
                            role: () {
                              switch (model.role) {
                                case Teacher():
                                  return index == studnetIndex
                                      ? StudentAndTeacher(
                                          const Student.empty(),
                                          model.role as Teacher,
                                        )
                                      : model.role;
                                case Student():
                                  return index == teacherIndex
                                      ? StudentAndTeacher(
                                          model.role as Student,
                                          const Teacher.empty(),
                                        )
                                      : model.role;
                                case StudentAndTeacher(
                                    student: final Student student,
                                    teacher: final Teacher teacher
                                  ):
                                  return index == teacherIndex
                                      ? student
                                      : teacher;
                              }
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
