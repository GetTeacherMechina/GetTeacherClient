import "package:getteacher/net/register/register_net_model.dart";
import "package:getteacher/views/register_screen/student_input.dart";

sealed class UserRole {
  const UserRole();

  bool isTeacher();
  bool isStudent();
}

class Teacher extends UserRole {
  const Teacher(this.bio);
  const Teacher.empty() : bio = "";
  final String bio;

  @override
  bool isTeacher() => true;

  @override
  bool isStudent() => false;
}

class Student extends UserRole {
  const Student(this.grade);
  const Student.empty() : grade = 1;
  final int grade;

  @override
  bool isTeacher() => false;

  @override
  bool isStudent() => true;
}

class StudentAndTeacher extends UserRole {
  const StudentAndTeacher(this.student, this.teacher);
  final Student student;
  final Teacher teacher;

  @override
  bool isTeacher() => true;

  @override
  bool isStudent() => true;
}

// Register class
class RegisterModel {
  const RegisterModel()
      : fullName = "",
        email = "",
        password = "",
        confirmedPassword = "",
        role = const Teacher("");

  const RegisterModel._hidden({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmedPassword,
    required this.role,
  });

  final String fullName;
  final String email;
  final String password;
  final String confirmedPassword;
  final UserRole role;

  RegisterRequestModel intoRegisterRequest() => RegisterRequestModel(
        fullName: fullName,
        email: email,
        password: password,
        teacherRequestModel: switch (role) {
          Teacher(bio: final String bio) ||
          StudentAndTeacher(teacher: Teacher(bio: final String bio)) =>
            TeacherRequestModel(bio: bio),
          Student() => null,
        },
        studentRequestModel: switch (role) {
          Student(grade: final int grade) ||
          StudentAndTeacher(student: Student(grade: final int grade)) =>
            StudentRequestModel(grade: grades[grade]!),
          _ => null,
        },
      );

  RegisterModel copyWith({
    final String Function()? fullName,
    final String Function()? email,
    final String Function()? password,
    final String Function()? confirmedPassword,
    final UserRole Function()? role,
  }) =>
      RegisterModel._hidden(
        fullName: fullName == null ? this.fullName : fullName(),
        email: email == null ? this.email : email(),
        password: password == null ? this.password : password(),
        confirmedPassword: confirmedPassword == null
            ? this.confirmedPassword
            : confirmedPassword(),
        role: role == null ? this.role : role(),
      );
}
