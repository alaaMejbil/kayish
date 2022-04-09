import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';

class MapScreen extends StatefulWidget {
  String? latitude;
  String? longtude;
  String? address;
  MapScreen({
    this.latitude,
    this.longtude,
    this.address
});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _googleMapController;
  BitmapDescriptor? icon;
  Set<Marker> marker={};
  bool showResult=true;

  @override
  void initState() {
    marker=Set.from([]);
    setCustomMarker();

    super.initState();
  }
  void setCustomMarker()async{
    icon= await BitmapDescriptor.fromAssetImage( ImageConfiguration(devicePixelRatio: 10), 'icons/map_marker.png');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).translate('Map')!,style: appBarTitle),
        centerTitle: true,
        elevation: 0.0,
        leading:IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),

      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:  CameraPosition(
              target: LatLng(	double.parse(widget.latitude!),  double.parse(widget.longtude!)),
              zoom: 16.4,
            ),
            onMapCreated: (controller){
              _googleMapController=controller;
              setState(() {
                 marker.add(Marker(
                   markerId:const  MarkerId('1'),
                    icon: icon!,

                   position:  LatLng(double.parse(widget.latitude!),  double.parse(widget.longtude!)),
                   onTap: (){

                      setState(() {
                       showResult=!showResult;
                      });

                   }


                 ));
              }
              );
            },
           markers:marker
          ),
          if(showResult)
          Positioned(
            top: 100,
            left: 0,
            right: 0,

            child: Padding(
            padding:  EdgeInsets.all(16.0),
               child: Card(
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                   child:Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            const Image(
                              height: 35,
                              width: 35,
                          image: AssetImage('icons/address_marker.png'),
                       ),
                         const SizedBox(width: 16,),
                          Expanded(
                            child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Text(
                                   AppLocalization.of(context).translate('address')!,
                                  style: Styles.getBoldMainTextStyle(color: Colors.grey.shade800,fontSize: FontSize.s14),
                                ),
                                const  SizedBox(height: 8,),
                              Text(
                                widget.address!,
                                style: Styles.getMidMainTextStyle(color: Colors.grey,fontSize: FontSize.s14),

                              ),

                              ],
                            ),
                          ),
                       ],
                       ),
                   ),
                  )
                ),
          ),
        ],
      ),
    );
  }
}
