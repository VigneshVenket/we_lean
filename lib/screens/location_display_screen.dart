import 'package:flutter/material.dart';
import 'package:we_lean/bloc/location/location_bloc.dart';
import 'package:we_lean/bloc/location/location_event.dart';
import 'package:we_lean/bloc/location/location_state.dart';
import 'package:we_lean/bloc/overall_ppc_data/overall_ppc_data_event.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/utils/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/widgets/custom_button_submit.dart';

import '../bloc/overall_ppc_data/overall_ppc_data_bloc.dart';
import '../repo/overall_ppc_data_repo.dart';
import '../utils/app_data.dart';
import '../utils/shared_pref_service.dart';
import '../widgets/custom_route.dart';
import 'main_screen.dart';



class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  int onLocationSelected=-1;


  @override
  void initState() {
    // TODO: implement initState

    BlocProvider.of<LocationsBloc>(context).add(FetchLocations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LocationsBloc,LocationsState>(
        builder: (context,state){
          if(state is LocationsLoaded){
            return Padding(
              padding: const EdgeInsets.only(top: 100.0,left: 10,right: 10),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.95,
                    height: MediaQuery.of(context).size.height*0.05,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:Color.fromRGBO(240, 240, 240, 1)),
                    child: Center(
                      child: Text("Select a location",style:titilliumSemiBold.copyWith(color: CustomColors.themeColor)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.95,
                    height: MediaQuery.of(context).size.height*0.7,
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: CustomColors.themeColorOpac),
                    // ),
                    child: ListView.builder(
                        itemCount: state.locations.length,
                        itemBuilder: (context,index){
                          // print(state.locations[index].name);
                          // String textAfterDash = state.locations[index].name.split('-')[1].trim();
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () async{
                                         setState(() {
                                           onLocationSelected=index;
                                         });
                                         AppData.projectLocation=state.locations[index];
                                         final sharedPrefService = await SharedPreferencesService.instance;
                                         await sharedPrefService.setProjectLocationId(state.locations[index].id);
                                         await sharedPrefService.setProjectLocationName(state.locations[index].name);

                                         print(AppData.projectLocation?.name);
                                         print(AppData.projectLocation?.id);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          width:40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color:Theme.of(context).brightness==Brightness.dark?
                                            Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(240, 240, 240, 1),
                                          ),
                                          child: Icon(Icons.location_pin,color: CustomColors.themeColorOpac,size: 24,),),
                                      SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.7,
                                        height: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top:15.0),
                                          child: Text(state.locations[index].name,
                                            textAlign:TextAlign.left,
                                            style:titilliumBoldRegular,),
                                        ),
                                      ),
                                      // SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                                      onLocationSelected==index?
                                      Icon(Icons.radio_button_on,color:Theme.of(context).brightness==Brightness.dark?
                                      Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1) ,size: 24,):
                                      Icon(Icons.radio_button_off,color: Theme.of(context).brightness==Brightness.dark?
                                      Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),size: 24,),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30,)
                              ],
                            );
                    }),
                  ),
                  CustomButtonSubmit(
                      title: "Submit",
                      onPressed: (){

                        CustomNavigation.pushAndRemoveUntill(context,

                            MultiBlocProvider(
                              providers: [
                                // BlocProvider(
                                //   create: (BuildContext context) {
                                //     return WeekVariancePPCBloc(RealWeekVariancePpcRepo())
                                //       ..add(FetchWeekVariancePPCData(userId: AppData.user!.id!));
                                //   },),
                                // BlocProvider(
                                //   create: (BuildContext context) {
                                //     return TodayPlanBloc(todayPlanRepo: RealTodayPlanRepo())
                                //       ..add(FetchTodayPlan(userId: AppData.user!.id!));
                                //   },),
                                // BlocProvider(
                                //   create: (BuildContext context) {
                                //     return BarChartBloc(barChartPpcRepo: RealBarChartPpcRepo())
                                //       ..add(FetchBarChartDataEvent(userId: AppData.user!.id!));
                                //   },),
                                BlocProvider(
                                  create: (BuildContext context) {
                                    return OverallPPCBloc(overallPpcDataRepo: RealOverallPpcDataRepo())
                                      ..add(FetchOverallPPCDataLocationwiseEvent(userId: AppData.user!.id!,projLocId: AppData.projectLocation!.id));
                                  },),
                              ],
                              child: MainScreen(),
                            )
                        );


                      })
                ],
              ),
            );
          }else{
            return Center(
              child: CircularProgressIndicator(
                color: CustomColors.themeColor,
              ),
            );
          }
        },
        listener: (context,state) {

        },
      )
    );
  }
}
