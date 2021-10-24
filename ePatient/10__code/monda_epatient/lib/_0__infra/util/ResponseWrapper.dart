class ResponseWrapper<T> {
  final bool isSuccess;

  final String? message;

  final T? data;

  ResponseWrapper.success({this.message, this.data}) : this.isSuccess = true;

  ResponseWrapper.error({this.message}) : this.data = null, this.isSuccess = false;
}
