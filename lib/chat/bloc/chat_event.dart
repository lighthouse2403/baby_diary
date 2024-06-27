import 'package:baby_diary/chat/thread_model.dart';
import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class LoadThreads extends ChatEvent {

  const LoadThreads();

  @override
  List<Object?> get props => [];
}

class LoadComment extends ChatEvent {
  String threadId;
  LoadComment(this.threadId);

  @override
  List<Object?> get props => [threadId];
}

class SendComment extends ChatEvent {
  ThreadModel thread;
  String comment;
  SendComment(this.thread, this.comment);

  @override
  List<Object?> get props => [thread, comment];
}