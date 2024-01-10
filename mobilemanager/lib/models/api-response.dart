class ApiResponse<T> {
  final Status status;
  final T? data;
  final String message;

  ApiResponse.success(this.data) : status = Status.SUCCESS, message = "";
  ApiResponse.error(this.message) : status = Status.ERROR, data = null;
  ApiResponse.unauthorized(this.message) : status = Status.UNAUTHORIZED, data = null;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { SUCCESS, ERROR, UNAUTHORIZED }