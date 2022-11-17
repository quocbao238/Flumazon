import 'package:flumazon/common/widgets/custom_textfield.dart';
import 'package:flumazon/common/widgets/loading_widget.dart';
import 'package:flumazon/constants/global_variables.dart';
import 'package:flumazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = '/address-Screen';
  final String totalAmount;
  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  List<PaymentItem> paymentItems = [];

  @override
  void initState() {
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amouint',
        status: PaymentItemStatus.final_price));

    super.initState();
  }

  @override
  void dispose() {
    flatBuildingController.dispose();
    areaController.dispose();
    pinCodeController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void onApplePayResult(res) {}

  void onGooglePayResult(res) {}

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: GlobalVariables.appBarGradient,
        ),
      )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: GlobalVariables.backgroundColor,
          child: Column(
            children: [
              if (address != null)
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Text(
                        address,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        '-- OR --',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CustomTextField(
                        controller: flatBuildingController,
                        hintText: 'Flat, House no, Building',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CustomTextField(
                        controller: areaController,
                        hintText: 'Area',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CustomTextField(
                        controller: pinCodeController,
                        hintText: 'Pin Code',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CustomTextField(
                        controller: cityController,
                        hintText: 'City',
                      ),
                    ),
                    ApplePayButton(
                      margin: const EdgeInsets.only(top: 16),
                      width: double.infinity,
                      height: 48,
                      style: ApplePayButtonStyle.whiteOutline,
                      type: ApplePayButtonType.buy,
                      paymentConfigurationAsset: 'applepay.json',
                      onPaymentResult: onApplePayResult,
                      paymentItems: paymentItems,
                      loadingIndicator: const Center(
                        child: LoadingWidget(),
                      ),
                    ),
                    GooglePayButton(
                      margin: const EdgeInsets.only(top: 16),
                      width: double.infinity,
                      height: 48,
                      type: GooglePayButtonType.buy,
                      paymentConfigurationAsset: 'gpay.json',
                      onPaymentResult: onGooglePayResult,
                      paymentItems: paymentItems,
                      loadingIndicator: const Center(
                        child: LoadingWidget(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
