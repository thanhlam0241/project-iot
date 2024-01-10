enum AddMachineState {
  SUCCESS,
  ERROR,
}

class AddMachineResponse {
  AddMachineResponse({required this.state, this.deviceCode});
  AddMachineState state;
  String? deviceCode;
}