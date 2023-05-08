import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_cmd.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:auto_reload/auto_reload.dart';

class PaymentListTile extends StatefulWidget {
  Projector projector;

  PaymentListTile({this.projector});

  @override
  State<PaymentListTile> createState() => _PaymentListTileState();
}

class _PaymentListTileState extends State<PaymentListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 0, right: 20),
      visualDensity: VisualDensity.standard,
      leading: Container(
        width: 50,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
            widget.projector.connected.getValue() ? Icons.settings_ethernet : Icons.code_off,
            // widget.projector.connected.getValue() ? Icons.wifi_tethering : Icons.wifi_tethering_off,
            size: 20),
      ),
      title: PrimaryText(
          text: widget.projector.name, size: 14, fontWeight: FontWeight.w500),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimaryText(
            text: widget.projector.ip,
            size: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
          ),
          PrimaryText(
              text: widget.projector.connected.getValue().toString(),
              size: 16,
              fontWeight: FontWeight.w600),
        ],
      ),
      onTap: () {
        setState(() {
          check_connection(widget.projector.ip, widget.projector.connected);
        });
        // startAutoReload();
      },
      selected: true,
    );
  }
}
