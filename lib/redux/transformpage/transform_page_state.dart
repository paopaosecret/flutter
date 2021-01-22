class TransformPageState{
  String params;

  TransformPageState({
    this.params,
  });

  TransformPageState.initState({
    this.params = "",
  });

  static TransformPageState copy(TransformPageState state) {
    return TransformPageState(
      params: state.params,
    );
  }
}