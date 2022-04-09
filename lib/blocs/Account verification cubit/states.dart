abstract class AccountVerificationStates {}
class AccountInitialState extends AccountVerificationStates{}

class ChangeCurrentIndexState extends AccountVerificationStates{}
class ChangeSelectedCity extends AccountVerificationStates{}
class PickWorkPremitState extends AccountVerificationStates{}
class DeletePickImageState extends AccountVerificationStates{}

class CameraPermissionGranted extends AccountVerificationStates{}
class CameraPermissionDenied extends AccountVerificationStates{}
class CameraPermissionError extends AccountVerificationStates{}

class PhotoPermissionGranted extends AccountVerificationStates{}
class PhotoPermissionDenied extends AccountVerificationStates{}
class PhotoPermissionError extends AccountVerificationStates{
}


//post fanction
class AccountVerificationLoadingState extends AccountVerificationStates{}
class AccountVerificationSuccessfulState extends AccountVerificationStates{}
class AccountVerificationErrorState extends AccountVerificationStates{}
class AccountVerificationErrorDataInputState extends AccountVerificationStates{}


class CitySuccessState extends AccountVerificationStates{}
class CityErrorState extends AccountVerificationStates{}

class AddOption extends AccountVerificationStates{}
class RemoveOption extends AccountVerificationStates{}


