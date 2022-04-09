abstract class DealsDetailsStates{}
class DealsDetailsInitialState extends DealsDetailsStates{}
class DealsDetailsIncreaseCounterState extends DealsDetailsStates{}
class DealsDetailsDecreaseCounterState extends DealsDetailsStates{}
class DealsDetailsResetBidValue extends DealsDetailsStates{}
class DealsIncreaseHighestPrice extends DealsDetailsStates{}


//get auction states

class DealsDetailsLoadingState extends DealsDetailsStates{}
class DealsDetailsSuccessfulState extends DealsDetailsStates{}
class DealsDetailsErrorState extends DealsDetailsStates{}
class DealsDetailsErrorDataInputState extends DealsDetailsStates{}


//firebase
class SendSuccessfulState extends DealsDetailsStates{}
class SendErrorState extends DealsDetailsStates{}
class SendAuctionLoadingState extends DealsDetailsStates{}
class GetSuccessfulState extends DealsDetailsStates{}

class ChangePageIndicator extends DealsDetailsStates{}


class SendBidToApiSuccessfulState extends DealsDetailsStates{}
class SendBidToApiErrorState extends DealsDetailsStates{}
class SendBidToApiLoadingState extends DealsDetailsStates{}


