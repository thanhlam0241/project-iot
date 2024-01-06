class ApiResponse<T> {
  final Status status;
  final T? data;
  final String message;

  ApiResponse.success(this.data) : status = Status.COMPLETED, message = "";
  ApiResponse.error(this.message) : status = Status.ERROR, data = null;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { SUCCESS, ERROR, COMPLETED, LOADING }