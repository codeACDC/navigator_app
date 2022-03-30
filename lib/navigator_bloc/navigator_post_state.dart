part of 'navigator_post_cubit.dart';

enum NavigatorPostStatus { loading, loaded, error, initial }

class NavigatorPostState extends Equatable {
  List<BirdModel> birdPost;
  NavigatorPostStatus status;

  NavigatorPostState({required this.birdPost, required this.status});

  @override
  List<Object> get props => [birdPost, status];

  NavigatorPostState copyWith({
    List<BirdModel>? birdPost,
    NavigatorPostStatus? status,
  }) {
    return NavigatorPostState(
      birdPost: birdPost ?? this.birdPost,
      status: status ?? this.status,
    );
  }
}
