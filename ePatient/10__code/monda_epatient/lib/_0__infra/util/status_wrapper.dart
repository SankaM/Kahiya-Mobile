class StatusWrapper<S, D, E> {
  S status;

  D? data;

  E? error;

  StatusWrapper({required this.status, this.data, this.error});
}