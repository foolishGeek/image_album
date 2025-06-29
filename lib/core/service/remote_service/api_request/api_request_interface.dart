enum RequestType { get, post, delete, put }

// Base class for our Api Request
sealed class ApiRequest {
  const ApiRequest();

  String get path;

  Map<String, Object>? get body => null;

  Map<String, String>? get customHeader => null;

  Map<String, Object>? get queryParams => null;
}

class GetRequest extends ApiRequest {
  final String overridePath;
  final Map<String, String>? customHeaders;
  final Map<String, String>? query;

  GetRequest(this.overridePath, {this.customHeaders, this.query});

  @override
  String get path => overridePath;

  @override
  Map<String, String>? get customHeader => customHeaders;

  @override
  Map<String, Object>? get queryParams => query;
}

class PostRequest extends ApiRequest {
  final String overridePath;
  final Map<String, String>? customHeaders;
  final Map<String, Object>? overrideBody;

  PostRequest(this.overridePath, {this.customHeaders, this.overrideBody});

  @override
  String get path => overridePath;

  @override
  Map<String, Object>? get body => overrideBody;

  @override
  Map<String, String>? get customHeader => customHeaders;
}
