import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_demo/common/util.dart';
import 'package:task_demo/constant/import.dart';
import 'package:task_demo/cubit/dashboard_module/dashboard_cubit.dart';
import 'package:task_demo/cubit/theme_module/provider/theme_cubit.dart';
import 'package:task_demo/cubit/theme_module/states/change_theme_states.dart';
import 'package:task_demo/entities/dashboard_module/product_response.dart';
import 'package:task_demo/repository/model/search_param.dart';
import 'package:task_demo/singleton/login_user.dart';
import 'package:task_demo/ui/common_components/custom_button.dart';
import 'package:task_demo/ui/common_components/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  final DashboardCubit dashboardCubit;
  const HomeScreen({super.key, required this.dashboardCubit});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  OverlayEntry? _overlayEntry;
  List<String> filteredSuggestions = [];
  final LayerLink _layerLink = LayerLink();
  List<String> allSearches = LoginUser.instance.userSearchStrings;

  @override
  void initState() {
    widget.dashboardCubit.getProductsApiCall();
    super.initState();
  }

  @override
  void dispose() {
    _removeOverlay();
    searchController.dispose();
    super.dispose();
  }

  void _filterProductList(String query) {
    if (query.isNotEmpty) {
      setState(() {
        filteredSuggestions =
            allSearches
                .where(
                  (search) =>
                      search.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      });
    } else {
      setState(() {
        filteredSuggestions = allSearches;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ChangeThemeState>(
      bloc: changeThemeCubit,
      builder: (context, themeState) {
        return Scaffold(
          backgroundColor: themeState.customColors[AppColors.white],
          appBar: baseAppBar(
            title: "My Shop",
            titleStyle: AppFontStyle.boldInterTextFiled.copyWith(
              color: themeState.customColors[AppColors.black],
            ),
            widgets: [
              InkWell(
                onTap: () {
                  if (LoginUser.instance.isDarkTheme) {
                    changeThemeCubit.changeToLightTheme();
                    LoginUser.instance.isDarkTheme = false;
                  } else {
                    changeThemeCubit.changeToDarkTheme();
                    LoginUser.instance.isDarkTheme = true;
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Icon(
                    LoginUser.instance.isDarkTheme
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    color: themeState.customColors[AppColors.black],
                  ),
                ),
              ),
            ],
          ),
          body: BlocConsumer<DashboardCubit, DashboardState>(
            bloc: widget.dashboardCubit,
            listener: (context, state) {
              if (state is DashboardLoadingState) {
                showLoader(context);
              } else if (state is DashboardErrorState) {
                hideLoader();
                showToastAlert(message: state.errorMessage);
              } else if (state is DashboardSuccessState) {
                hideLoader();
                print(widget.dashboardCubit.productResponse?.total.toString());
              }
            },
            buildWhen: (preSate, curState) {
              return curState is DashboardSuccessState;
            },
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: CompositedTransformTarget(
                            link: _layerLink,
                            child: CommonTextField(
                              controller: searchController,
                              themeState: themeState,
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              keyboardType: TextInputType.text,
                              filled: true,
                              onChange: (value) {
                                if (value == "") {
                                  widget.dashboardCubit.getProductsApiCall();
                                  _removeOverlay();
                                } else {
                                  _filterProductList(value);
                                  _showOverlay();
                                }
                              },
                              fillColor:
                                  themeState.customColors[AppColors
                                      .cardBackground],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        CommonButton(
                          text: "Search",
                          onTap: () async {
                            LoginUser.instance.userSearchStrings.add(
                              searchController.text,
                            );
                            allSearches = LoginUser.instance.userSearchStrings;
                            await LoginUser.instance.storeUserDataToLocal(
                              MDLUser(
                                userId: LoginUser.instance.userId,
                                searchKey: jsonEncode(
                                  LoginUser.instance.userSearchStrings,
                                ),
                                authToken: "token",
                              ),
                            );
                            widget.dashboardCubit.getProductsApiCall(
                              param: MDLProductSearchRequest(
                                q: searchController.text,
                                limit: 50,
                              ),
                            );
                          },
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Showing"),
                          Text(
                            "${widget.dashboardCubit.productResponse?.products?.length.toString() ?? ""}/${widget.dashboardCubit.productResponse?.total.toString() ?? ""}",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  (state is DashboardLoadingState)
                      ? CircularProgressIndicator()
                      : Expanded(
                        child: ListView.builder(
                          itemCount:
                              widget
                                  .dashboardCubit
                                  .productResponse
                                  ?.products
                                  ?.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return productTile(
                              item:
                                  widget
                                      .dashboardCubit
                                      .productResponse
                                      ?.products?[index] ??
                                  Products(),
                              themeState: themeState,
                            );
                          },
                        ),
                      ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget productTile({
    required ChangeThemeState themeState,
    required Products item,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: themeState.customColors[AppColors.cardBackground],
      shadowColor: themeState.customColors[AppColors.lightGrey],
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                item.thumbnail ?? '',
                width: 80.w,
                height: 80.w,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(
                      width: 80.w,
                      height: 80.w,
                      color: Colors.grey[300],
                      child: Icon(Icons.image, size: 40.sp),
                    ),
              ),
            ),
            const SizedBox(width: 12),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    item.title ?? 'No title',
                    style: AppFontStyle.boldInterTextFiled.copyWith(
                      color: themeState.customColors[AppColors.black],
                      fontSize: 18.sp,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Rating
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16.sp,
                        color:
                            themeState.customColors[AppColors.orange] ??
                            Colors.orange,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        item.rating?.toStringAsFixed(1) ?? '0.0',
                        style: AppFontStyle.boldInterTextFiled.copyWith(
                          color: themeState.customColors[AppColors.darkGrey],
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 4.w),

                  // Description
                  Text(
                    item.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppFontStyle.regularInterTextFiled.copyWith(
                      color: themeState.customColors[AppColors.darkGrey],
                      fontSize: 14.sp,
                    ),
                  ),

                  SizedBox(height: 6.w),

                  // Price and Brand
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹${item.price?.toStringAsFixed(2) ?? '--'}",
                        style: AppFontStyle.boldInterTextFiled.copyWith(
                          color: themeState.customColors[AppColors.green],
                          fontSize: 18.sp,
                        ),
                      ),
                      Text(
                        item.brand ?? '',
                        style: AppFontStyle.regularInterTextFiled.copyWith(
                          color: themeState.customColors[AppColors.darkGrey],
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    _removeOverlay(); // Remove previous overlay if any

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            width: size.width - 24.w, // match parent padding
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: Offset(12.w, 70.h),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredSuggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = filteredSuggestions[index];
                    return ListTile(
                      title: Text(suggestion),
                      onTap: () {
                        searchController.text = suggestion;
                        _removeOverlay();
                        // Call API using this selected search keyword
                        widget.dashboardCubit.getProductsApiCall(
                          param: MDLProductSearchRequest(
                            q: suggestion,
                            limit: 50,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }
}
