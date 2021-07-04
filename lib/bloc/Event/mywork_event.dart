part of '../Bloc/mywork_bloc.dart';

abstract class MyworkEvent extends Equatable {
  const MyworkEvent();

  @override
  List<Object> get props => [];
}

class getActiveWork extends MyworkEvent {}

class getPastWork extends MyworkEvent {}

class getWorkerDetails extends MyworkEvent {
  final String id;
  getWorkerDetails(this.id);
}

class getWorkerReviews extends MyworkEvent {
  final String id;
  getWorkerReviews(this.id);
}

class getWorkDetails extends MyworkEvent {
  final String id;
  getWorkDetails(this.id);
}

class getSelectedClientReview extends MyworkEvent {
  final String id;
  getSelectedClientReview(this.id);
}

class markContractAsCompleted extends MyworkEvent {
  final String id;
  markContractAsCompleted(this.id);
}

class getClarification extends MyworkEvent {
  final String id;
  getClarification(this.id);
}

class postClarification extends MyworkEvent {
  final String id, text;
  postClarification(this.id, this.text);
}

class getCancelList extends MyworkEvent {}

class cancelContract extends MyworkEvent {
  final String contractID, cancelHint, cancelDetails;

  cancelContract(this.contractID, this.cancelHint, this.cancelDetails);
}

class getReportList extends MyworkEvent {}

class reportContract extends MyworkEvent {
  final String contractID, reportHint, reportDetails;

  reportContract(this.contractID, this.reportHint, this.reportDetails);
}

class sendInvoice extends MyworkEvent {
  final String contractID, hour, minute;

  sendInvoice(this.contractID, this.hour, this.minute);
}

class postClientReview extends MyworkEvent {
  final String contractID, clientID, details;
  final int rating;
  postClientReview(this.contractID, this.clientID, this.rating, this.details);
}
