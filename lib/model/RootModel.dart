class RootModel<T> {
  RootModel(this.data, this.errorcode, this.errormsg);

  T data;
  int errorcode;
  String errormsg;
}
