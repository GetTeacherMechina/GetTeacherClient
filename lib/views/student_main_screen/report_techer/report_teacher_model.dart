class ReportTeacherModel {
  const ReportTeacherModel()
    : report = "";
  
  const ReportTeacherModel._hidden({
    required this.report,
  });

  final String report;

  ReportTeacherModel copyWith({
    final String Function()? report,
  }) => 
        ReportTeacherModel._hidden(
          report: report != null ? report() : this.report,
        );
}