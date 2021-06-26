class TemplateString {
  final String stringWithParams;

  final Map<String, String>? params;

  TemplateString({required this.stringWithParams, this.params});

  @override
  String toString() {
    String result = stringWithParams;

    if(params != null) {
      params!.forEach((key, value) {
        String willBeReplaced = '{' + key + '}';
        String replacement = value;

        result = result.replaceAll(willBeReplaced, replacement);
      });
    }

    return result;
  }
}
