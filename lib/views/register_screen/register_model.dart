sealed class UserRole {
  const UserRole();
}

class Teacher extends UserRole {
  const Teacher(this.bio);
  final String bio;
}

class Student extends UserRole {
  const Student(this.grade);
  final String grade;
}

class StudentAndTeacher extends UserRole {
  const StudentAndTeacher(this.student, this.teacher);
  final Student student;
  final Student teacher;
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
