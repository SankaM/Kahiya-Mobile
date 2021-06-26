abstract class AbstractResult {
  final bool success;

  final String? errorMessage;

  AbstractResult.success() : success = true, errorMessage = null;

  AbstractResult.error({this.errorMessage}) : success = false;
}
