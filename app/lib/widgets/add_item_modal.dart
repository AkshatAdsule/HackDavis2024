import 'package:app/services/food_api.dart';
import 'package:app/util/food_data.dart';
import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class AddItemModal extends StatefulWidget {
  const AddItemModal({super.key});

  @override
  State<AddItemModal> createState() => _AddItemModalState();
}

class _AddItemModalState extends State<AddItemModal> {
  bool _isScanning = false;
  bool _isSearching = false;
  bool _isItemFound = false;

  String _status = "Scan your object's barcode!";

  FoodData? _item;

  Future<FoodData?> _lookUpItem(int upc) async {
    setState(() {
      _isSearching = true;
      _status = "Looking up item...";
    });
    // _item = await FoodApi().getResponse(upc);

    _item = FoodData(
      name: "Enlighten Mint Yerba Mate, Enlighten Mint",
      image:
          "https://www.edamam.com/food-img/621/6210025518f6a76f8c2015f33fc4e3a3.jpg",
      score: 10,
      quantity: 1,
    );

    if (_item == null) {
      setState(() {
        _isSearching = false;
        _status = "Item not found!";
        _isItemFound = false;
      });
      return null;
    }
    setState(() {
      _isSearching = false;
      _status = "Item found!";
      _isItemFound = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width),
        !_isScanning
            ? OutlinedButton(
                onPressed: !_isSearching
                    ? () {
                        setState(() {
                          _isScanning = true;
                        });
                      }
                    : null,
                child: const Text("Scan Bar Code"),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.8,
                child: QrCamera(
                  cameraDirection: CameraDirection.BACK,
                  formats: const [
                    BarcodeFormats.UPC_A,
                    BarcodeFormats.UPC_E,
                    BarcodeFormats.EAN_13,
                    BarcodeFormats.EAN_8
                  ],
                  qrCodeCallback: (value) {
                    setState(() {
                      _isScanning = false;
                      _lookUpItem(int.parse(value!));
                    });
                    print(value);
                  },
                ),
              ),
        Expanded(
          child: Center(
            child: Text(_status),
          ),
        ),
        OutlinedButton(
          onPressed: _isItemFound
              ? () {
                  Navigator.of(context).pop(_item);
                }
              : null,
          child: const Text("Confirm Item"),
        ),
      ],
    );
  }
}
