abstract class InComingAuctionStates{}
class InComingAuctionInitialState extends InComingAuctionStates{}
class InComingAuctionLoadingState extends InComingAuctionStates{

}
class InComingAuctionSuccessfulState extends InComingAuctionStates{}
class InComingAuctionErrorState extends InComingAuctionStates{}
class InComingAuctionErrorDataInputState extends InComingAuctionStates{

}

class UpdateCurrent extends InComingAuctionStates{}

class  FollowLoadingState extends InComingAuctionStates{}
class  FollowSuccessfulState extends InComingAuctionStates{}
class FollowErrorState extends InComingAuctionStates{}
class FollowErrorDataInputState extends InComingAuctionStates{}
