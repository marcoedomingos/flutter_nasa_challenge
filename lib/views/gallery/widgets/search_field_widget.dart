import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final Color iconColor;
  final Function(String) onFinished;

  const SearchFieldWidget({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.iconColor,
    required this.onFinished,
  });

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 50,
        padding: const EdgeInsets.only(left: 12),
        child: TextFormField(
          controller: widget.controller,
          readOnly: true,
          onTap: () {
            showDialog(context: context, builder: (_) => AlertDialog(
              content: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: CalendarDatePicker(
                    initialDate: DateTime.tryParse(widget.controller.text) ?? DateTime.now(),
                    firstDate: DateTime.parse("2012-01-01"),
                    lastDate: DateTime.now(),
                    onDateChanged: (value) {
                      widget.controller.text = value.toString().substring(0, 10);
                      Modular.to.pop();
                      widget.onFinished(widget.controller.text);
                    }),
              ),
            ));
                },
          onFieldSubmitted: (value) => widget.onFinished(value),
          decoration: InputDecoration(
              hintText: widget.hint,
              border: InputBorder.none,
              suffixIcon: Icon(
                widget.icon,
                color: widget.iconColor,
              )),
        ),
      ),
    );
  }
}
