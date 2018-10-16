class RootModel<T> {
  RootModel(this.data, this.errorCode, this.errorMsg);

  T data;
  int errorCode;
  String errorMsg;
}
