import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navigator_app_2/models/bird_model.dart';

part 'navigator_post_state.dart';

class NavigatorPostCubit extends Cubit<NavigatorPostState>{
NavigatorPostCubit(): super(NavigatorPostState(birdPost: [], status: NavigatorPostStatus.initial));

void addNavigatorPost(BirdModel birdModel){
  emit(state.copyWith(status: NavigatorPostStatus.loading));

  List<BirdModel> birdPost = state.birdPost;
  birdPost.add(birdModel);

  emit(state.copyWith(birdPost: birdPost, status: NavigatorPostStatus.loaded));
}
}