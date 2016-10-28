# TravelMate iOS

## Build Setting
Xcode의 쓸데없는 로그가 나오지 않게 하려면 `Edit Scheme` 에서 `”Run” > “Arguments” > “Environment Variables”` 에 다음과 같은 값을 추가해야합니다.

`Name` 에는 `OS_ACTIVITY_MODE` 를 추가하고 `Value` 에는 `disable` 을 입력후 왼쪽 체크박스를 체크한 상태로 둡니다.
