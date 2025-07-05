class MDLProductSearchRequest {
  String? q;
  int? limit;

  MDLProductSearchRequest({this.q, this.limit});

  Map<String, dynamic> toQueryMap() {
    final map = <String, dynamic>{};
    if (q != null && q!.trim().isNotEmpty) {
      map['q'] = q;
    }
    map['limit'] = limit ?? 10;
    return map;
  }
}
