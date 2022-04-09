abstract class SortStates {}

class InitialSortState extends SortStates {}

class ChangeRegionState extends SortStates {}

class ChangeNeighbourhoodState extends SortStates {}

class ChangeCityState extends SortStates {}

class ChangeEstateTypeState extends SortStates {}

class ChangeEstateDurationState extends SortStates {}

class ChangeAuctionState extends SortStates {}

class RegionSuccessState extends SortStates {}
class RegionErrorState extends SortStates {}

class CitySuccessState extends SortStates {}
class CityErrorState extends SortStates {}

class DistrictSuccessState extends SortStates {}
class DistrictErrorState extends SortStates {}

class RealStateTypeSuccessState extends SortStates {}
class RealStateTypeErrorState extends SortStates {}

class ChangeLoadingState extends SortStates {}