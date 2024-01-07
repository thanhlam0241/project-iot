import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilemanager/models/attendance-machine.dart';

import 'machine-detail-controller.dart';

class MachineDetail extends StatefulWidget {
  final String machineId;

  MachineDetail({Key? key, required this.machineId}) : super(key: key);

  @override
  State<MachineDetail> createState() => MachineDetailState();
}

class MachineDetailState extends State<MachineDetail> {
  late MachineDetailController controller;

  MachineDetailState() {
    controller = MachineDetailController(state: this);
  }

  @override
  void initState() {
    super.initState();
    controller.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(controller.machine?.name ?? "Chi tiết máy _"),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        const Text("Tên máy: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          width: 3,
                        ),
                        Expanded(
                          child: (!controller.nameIsEditing)
                              ? Text(
                                  controller.machine?.name ?? "Không biết",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                )
                              : TextField(
                                  controller: controller.nameController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.deepPurple,
                                    )),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                  textAlign: TextAlign.left,
                                  onChanged: (value) {
                                    controller.name = value;
                                  },
                                  focusNode: controller.nameFocusNode,
                                ),
                        ),
                        controller.isDisabled || controller.machine == null
                            ? const SizedBox()
                            : IconButton(
                                onPressed: controller.updateName,
                                icon: Icon(
                                  controller.nameIsEditing
                                      ? Icons.check
                                      : Icons.edit,
                                  color: Colors.deepPurple,
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Mã máy: ${controller.machine?.code ?? "Không biết"}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Đơn vị quản lý: ${controller.machine?.managementUnitName ?? "Chưa được liên kết"}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: (controller.isLinkingWithUnit == false)
                        ? FilledButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  controller.isDisabled ? Colors.grey : Colors.indigoAccent
                              ),
                            ),
                            onPressed: controller.isDisabled
                                ? null
                                : controller.linkWithUnit,
                            child: const Text("Liên kết"),
                          )
                        : OutlinedButton(
                            onPressed: controller.isDisabled
                                ? null
                                : controller.unlinkWithUnit,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              foregroundColor:
                                  MaterialStateProperty.all(controller.isDisabled ? Colors.grey : Colors.red),
                              side: MaterialStateProperty.all(
                                  BorderSide(color: (controller.isDisabled ? Colors.grey : Colors.red))),
                            ),
                            child: const Text("Hủy liên kết"),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 10),
    ));
  }
}
