import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:WareSmart/constant/Screen.dart';
import 'package:WareSmart/controller/logincontroller/logincontroller.dart';
import 'package:WareSmart/widgets/colorpalate.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  bool isvalid = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider<logincontroller>(
        create: (context) => logincontroller(),
        builder: (context, child) {
          return Consumer<logincontroller>(
              builder: (BuildContext context, loginCon, child) {
            return Scaffold(
              // backgroundColor: theme.primaryColor.withOpacity(0.01),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                     color:  Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.03,
                      
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: Screens.padingHeight(context),
                       
                          // color: Colors.amber,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          Screens.padingHeight(context) * 0.26,
                                      width: Screens.width(context),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "WareSmart",
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.bodyText1!
                                                .copyWith(color: theme.primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30),
                                          ),
                                          SizedBox(
                                            height:
                                                Screens.padingHeight(context) *
                                                    0.01,
                                          ),
                                          Text(
                                              "For Optimized Warehouse Operations",
                                              textAlign: TextAlign.center,
                                              style: theme.textTheme.bodyText1!
                                                  .copyWith(
                                                      color: theme.primaryColor,
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 18
                                                      )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.05,
                                    ),
                                    Container(
                                      child: Form(
                                        key: loginCon.formkey[0],
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                              Visibility(
                                    visible: loginCon.erroMsgVisble,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: Screens.width(context),
                                      child: Column(
                                        children: [
                                          Text(
                                            loginCon.errorMsh,
                                            style: theme.textTheme.bodyText1
                                                ?.copyWith(color: Colors.red),
                                            maxLines: 4,
                                          ),
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.02,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                            // Text("User Code",
                                            //     style: theme
                                            //         .textTheme.bodyText1!
                                            //         .copyWith(
                                            //             fontWeight:
                                            //                 FontWeight.bold)),
                                            // SizedBox(
                                            //   height:
                                            //       Screens.padingHeight(context) * 0.01,
                                            // ),
                                            //       TextFormField(
                                            //   cursorColor: Colors.green,
                                            //   // controller:
                                            //   //     context.watch<LoginCtrl>().userrnameCtrlr,
                                            //   validator: (value) {
                                            //     if (value == null || value.isEmpty) {
                                            //       return 'Please enter username';
                                            //     }

                                            //     return null;
                                            //   },
                                            //   decoration: InputDecoration(
                                            //     contentPadding: const EdgeInsets.fromLTRB(
                                            //         20.0, 15.0, 20.0, 15.0),
                                            //     hintText: 'Enter Your Username',
                                            //     prefixIcon:
                                            //         const Icon(Icons.person_2_outlined),
                                            //     filled: true,
                                            //     fillColor: Colors.white,
                                            //     border: OutlineInputBorder(
                                            //       borderRadius: BorderRadius.circular(10.0),
                                            //       borderSide: BorderSide.none,
                                            //     ),
                                            //   ),
                                            // ),
                                            SizedBox(
                                              height: Screens.padingHeight(
                                                      context) *
                                                  0.01,
                                            ),
                                            Container(
                                              // height: Screens.padingHeight(context)*0.06,
                                              child: TextFormField(
                                                controller:
                                                    loginCon.mycontroller[0],
                                                validator: (val) {
                                                  if (val!.isEmpty) {
                                                    return "*Required UserCode";
                                                  }
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                        // hintText: "User Code",
                                                        filled: true,
                                                        labelText: "User Code",
                                                        prefixIcon: const Icon(Icons
                                                            .person_2_outlined),
                                                            labelStyle: TextStyle(
                                                            ),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                        border: OutlineInputBorder(
                                                      // borderSide: BorderSide.none,
                                                      // borderSide: BorderSide(
                                                      //   color: Colors.black,
                                                      //     width: 1.5
                                                      // ),

                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8))),
                                                      //             enabledBorder: OutlineInputBorder(
                                                      // // borderSide: BorderSide.none,
                                                      // borderSide: BorderSide(
                                                      //   color: Colors.black,
                                                      //     width: 1.5
                                                      // ),

                                                      // borderRadius:
                                                      //     BorderRadius.all(
                                                      //         Radius.circular(
                                                      //             8))),focusedBorder: OutlineInputBorder(
                                                      // // borderSide: BorderSide.none,
                                                      // borderSide: BorderSide(
                                                      //   color: Colors.black,
                                                      //     width: 1.5
                                                      // ),

                                                      // borderRadius:
                                                      //     BorderRadius.all(
                                                      //         Radius.circular(
                                                      //             8))),
                                                      //             errorBorder: OutlineInputBorder(
                                                      // // borderSide: BorderSide.none,
                                                      // borderSide: BorderSide(
                                                      //    color: Colors.black,
                                                      //     width: 1.5
                                                      // ),

                                                      // borderRadius:
                                                      //     BorderRadius.all(
                                                      //         Radius.circular(
                                                      //             8))),focusedErrorBorder: OutlineInputBorder(
                                                      // // borderSide: BorderSide.none,
                                                      // borderSide: BorderSide(
                                                      //    color: Colors.black,
                                                      //     width: 1.5
                                                      // ),

                                                      // borderRadius:
                                                      //     BorderRadius.all(
                                                      //         Radius.circular(
                                                      //             8))),
                                                                            ),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: Screens.padingHeight(
                                            //           context) *
                                            //       0.015,
                                            // ),
                                            // Text("Password",
                                            //     style: theme
                                            //         .textTheme.bodyText1!
                                            //         .copyWith(
                                            //             fontWeight:
                                            //                 FontWeight.bold)),
                                            SizedBox(
                                              height: Screens.padingHeight(
                                                      context) *
                                                  0.02,
                                            ),
                                            Container(
                                              //  height: Screens.padingHeight(context)*0.06,
                                              child: TextFormField(
                                                controller:
                                                    loginCon.mycontroller[1],
                                                validator: (val) {
                                                  if (val!.isEmpty) {
                                                    return "*Required Password";
                                                  }
                                                },
                                                obscureText: loginCon.passwordvisible,
                                                decoration:
                                                     InputDecoration(
                                                  // hintText: "Password",
                                                  filled: true,
                                                  labelText: "Password",
                                                  
                                                  suffixIcon: IconButton(
                                                  
                                                    onPressed: (){

loginCon.onchangedpass();
                                                    }, 
                                                    icon:loginCon.passwordvisible ? Icon(Icons.visibility_off)
                          :  Icon(Icons.visibility), 
                                                    ),
                                                  labelStyle: TextStyle(
                                                            ),
                                                  prefixIcon: Icon(Icons.lock),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                  border: OutlineInputBorder(
                                                      // borderSide: BorderSide.none,
                                                      // borderSide: BorderSide(
                                                      //   color: Colors.black,
                                                      //     width: 1.5
                                                      // ),
                                                      

                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8))),
                                                    
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: Screens.padingHeight(
                                                      context) *
                                                  0.01,
                                            ),
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Checkbox(
                                                    value: isvalid,
                                                    // overlayColor: Colors.black,

                                                    activeColor:
                                                         theme.primaryColor,
                                                        checkColor:Colors.white,
                                                        
                                                    onChanged: (val) {
                                                      setState(() {
                                                        isvalid = !isvalid;
                                                      });
                                                    }),
                                                Text(
                                                  "I agree the ",
                                                  style:
                                                      theme.textTheme.bodyText1,
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                color: theme
                                                                    .primaryColor))),
                                                    child: Text(
                                                      "Terms & Conditions",
                                                      style: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                        color:
                                                            theme.primaryColor,
                                                        // fontWeight:
                                                        //     FontWeight.bold,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Screens.padingHeight(
                                                      context) *
                                                  0.01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                 Container(
                                                  width:
                                                      Screens.width(context) *
                                                          0.45,
                                                  height: Screens.padingHeight(
                                                          context) *
                                                      0.06,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8))
                                                      //  border: Border.all(
                                                      //   color: Colors.black,
                                                      //   width: 1.5
                                                      //  ) 
                                                      ),
                                                  child: ElevatedButton(
                                                      onPressed: () async{
                                                        showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4))),
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      insetPadding:
                                                          EdgeInsets.all(Screens
                                                                  .bodyheight(
                                                                      context) *
                                                              0.02),
                                                      content: settings(
                                                          context, loginCon));
                                                });
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(),
                                                      child:
                                                           Text("Setup",style:theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(color: Colors.white,))),
                                                ),
                                                Container(
                                                  width:
                                                      Screens.width(context) *
                                                          0.45,
                                                  height: Screens.padingHeight(
                                                          context) *
                                                      0.06,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8))
                                                      //  border: Border.all(
                                                      //   color: Colors.black,
                                                      //   width: 1.5
                                                      //  ) 
                                                      ),
                                                  child: ElevatedButton(
                                                      onPressed: isvalid==false||loginCon.isloading==true?(){}:
                                                       () {
                                                        loginCon
                                                            .validatelogin(context);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                            // backgroundColor: isvalid==false?Colors.grey:theme.primaryColor
                                                          ),
                                                      child:
                                                       loginCon.isloading==false?    Text("Login",style:theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                            color: Colors.white,
                                                           )):SpinKitThreeBounce(
                                                            size: Screens.width(context)*0.05,
                                                            color: Colors.white,
                                                           )
                                                           )
                                                           
                                                ),
                                               
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    bottom:
                                        Screens.padingHeight(context) * 0.02),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("App Version 2.0.0",
                                        style: theme.textTheme.bodyText1!
                                            .copyWith()),
                                    Text(" | ",
                                        style: theme.textTheme.bodyText1!
                                            .copyWith()),
                                    Text("Api Version 2.0.0",
                                        style: theme.textTheme.bodyText1!
                                            .copyWith())
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }
  settings(BuildContext context, logincontroller logCon) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.01,
            left: Screens.width(context) * 0.03,
            right: Screens.width(context) * 0.03,
            bottom: Screens.padingHeight(context) * 0.01),
        width: Screens.width(context) * 1.1,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Screens.width(context),
                height: Screens.padingHeight(context) * 0.05,
                color: theme.primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: Screens.padingHeight(context) * 0.02,
                          right: Screens.padingHeight(context) * 0.02),
                      // color: Colors.red,
                      width: Screens.width(context) * 0.7,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Configure",
                        style: theme.textTheme.bodyText2
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          size: Screens.padingHeight(context) * 0.025,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
              Form(
                key: logCon.formkey[1],
                child: Column(
                  children: [
                   
                    Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.001),
                      ),
                      child: TextFormField(
                        autofocus: true,
                        controller: logCon.mycontroller[3],
                        cursorColor: Colors.grey,
                        //keyboardType: TextInputType.number,
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the Customer Id';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintText: 'Customer ID',
                          hintStyle: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                          filled: false,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 25,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: logCon.progrestext == true
                    ? null
                    : () {
                        st(() {
                          logCon.settingvalidate(context);
                        });
                      },
                child: Container(
                  alignment: Alignment.center,
                  height: Screens.padingHeight(context) * 0.045,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                  ),
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: logCon.progrestext == true
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Ok",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyText1
                                  ?.copyWith(color: Colors.white),
                            ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
