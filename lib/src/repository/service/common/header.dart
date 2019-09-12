class Header {

  bool _isInternal;
  String type;
  String value;
  String token;
  String taxId;

  Header(this._isInternal, this.type, this.value, this.taxId);

  set isInternal(bool isInternal) {
    this._isInternal = isInternal;
  }

  bool get isInternal => _isInternal;

}
