class ApiResponse<T> {
  final ApiStatus status;
  final T? data;
  final String message;

  ApiResponse.success(this.data) : status = ApiStatus.SUCCESS, message = "";
  ApiResponse.error(this.message) : status = ApiStatus.ERROR, data = null;
  ApiResponse.unauthorized(this.message) : status = ApiStatus.UNAUTHORIZED, data = null;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum ApiStatus { SUCCESS, ERROR, UNAUTHORIZED }