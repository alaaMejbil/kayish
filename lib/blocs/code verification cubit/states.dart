abstract class VerificationCodeStates{}
class VerificationCodeInitialState extends VerificationCodeStates{}
class VerificationCodeLoadingState extends VerificationCodeStates{}
class VerificationCodeSuccessfulState extends VerificationCodeStates{}
class VerificationCodeErrorState extends VerificationCodeStates{}
class VerificationCodeErrorDataInputState extends VerificationCodeStates{}
class TimeFinishedState extends VerificationCodeStates{}

class PostFcmTokenLoadingState extends VerificationCodeStates{}
class PostFcmTokenSuccessfulState extends VerificationCodeStates{}
class PostFcmTokenErrorState extends VerificationCodeStates{}







