import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const AccountButton({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.black12.withOpacity(0.03),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          onPressed: () => onPressed?.call(),
          child: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
