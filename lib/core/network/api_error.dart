// class ApiError for handling api errors in the app
class ApiError {
  ApiError({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() {
    return  message ;
  }
}
// علشان لما يكون في مشكله اعرض لليوزر error message