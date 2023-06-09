import 'package:flutter/material.dart';
import 'package:getx_tutorial/common/constants.dart';
import 'package:getx_tutorial/models/record.dart';
import 'package:getx_tutorial/viewmodels/controller.dart';
import 'package:getx_tutorial/views/edit_record.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class RecordListTile extends StatelessWidget {
  const RecordListTile({Key? key, required this.record}) : super(key: key);
  final Record record;

  @override
  Widget build(BuildContext context) {
    final Controller _controller = Get.find();

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.cornerRadii)),
      child: Padding(
        padding: const EdgeInsets.only(left: 0, top: 8, right: 0, bottom: 0),
        child: ListTile(
          leading: buildDate(context),
          title: buildWeight(context),
          trailing: buildIcons(_controller),
        ),
      ),
    );
  }

  Widget buildIcons(Controller _controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 30,
          child: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.edit,
              color: Colors.grey.shade500,
            ),
            onPressed: () {
              Get.to(() => EditRecordScreen(record: record));
            },
          ),
        ),
        SizedBox(
          width: 30,
          child: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
            onPressed: () {
              Get.defaultDialog(
                title: 'Delete Record',
                titleStyle: TextStyle(fontWeight: FontWeight.bold),
                middleText: 'Are you sure?',
                textConfirm: 'Yes',
                buttonColor: Colors.white,
                onConfirm: () {
                  _controller.deleteRecord(record);
                  Get.back();
                },
                textCancel: 'No',
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildDate(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat('EEE, MMM d').format(record.dateTime),
              style: Theme.of(context).textTheme.bodyText1),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.note,
                size: 16,
                color: record.note == ''
                    ? Colors.transparent
                    : Colors.grey.shade400,
              ),
              Icon(
                Icons.photo_rounded,
                size: 16,
                color: record.photoUrl == null
                    ? Colors.transparent
                    : Colors.grey.shade400,
              ),
            ],
          )
        ],
      );

  Widget buildWeight(BuildContext context) => Center(
          child: Text(
        record.weight.toStringAsFixed(1),
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
      ));
}
