import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baby_diary/common/base/base_statefull_widget.dart';
import 'package:baby_diary/common/constants/constants.dart';
import 'package:baby_diary/common/extension/date_time_extension.dart';
import 'package:baby_diary/common/extension/text_extension.dart';
import 'package:baby_diary/home/bloc/home_bloc.dart';
import 'package:baby_diary/home/bloc/home_event.dart';
import 'package:baby_diary/home/bloc/home_state.dart';
import 'package:baby_diary/home/components/heart_indicator.dart';
import 'package:baby_diary/home/components/home_item.dart';
import 'package:baby_diary/routes/route_name.dart';
import 'package:baby_diary/routes/routes.dart';

class Home extends BaseStatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends BaseStatefulState<Home> {
  HomeBloc homeBloc = HomeBloc()..add(InitBabyEvent());

  @override
  Widget? buildBody() {
    return BlocProvider(
        create: (context) => homeBloc,
        child: BlocListener<HomeBloc, HomeState> (
            listener: (context, state) {
              if (state is LoadingBabySuccessfullyState) {
                setState(() {
                });
              }
            },
            child: InkWell(
              onTap: () {
                Routes.instance.navigateTo(RoutesName.babyWeightList).then((value) {
                  homeBloc.add(InitBabyEvent());
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/pregnancy_backgroound_3.jpg'),
                      fit: BoxFit.cover
                  ),
                ),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: SafeArea(
                        child: Container(
                            height: 260.0,
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              children: [
                                HeartIndicator(),
                                const SizedBox(width: 20),
                                Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _babyInformationRow(0),
                                        const SizedBox(height: 20),
                                        _babyInformationRow(1),
                                        const SizedBox(height: 20),
                                        _babyInformationRow(2),
                                        const SizedBox(height: 20),
                                        _babyInformationRow(3),
                                        const SizedBox(height: 20),
                                        _babyInformationRow(4),
                                      ],
                                    )
                                ),
                              ],
                            )
                        ),
                      ),
                    ),
                    SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0),
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          return HomeItem(index: index);
                        },
                        childCount: Constants.homeItems.length,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 20,
                      ),
                    )
                  ],
                ),
              ),
            )
        )
    );
  }

  Widget _babyInformationRow(int index) {
    String title = '';
    String content = '-';
    DateTime? birthDate = homeBloc.currentBaby?.birthDate;
    String motherName = '';
    String babyName = homeBloc.currentBaby?.babyName ?? '';

    switch (index) {
      case 0:
        title = 'Mẹ bầu:';
        content = motherName.isNotEmpty ? motherName : '-';
        break;
      case 1:
        title = 'Bé yêu:';
        content = babyName.isNotEmpty ? babyName : '-';
        break;
      case 2:
        title = 'Dự sinh:';
        content = birthDate == null ? '--/--/----' : birthDate.globalDateFormat();
        break;
      case 3:
        title = 'Tuổi thai:';
        if (birthDate == null) {
          content = '-';
          break;
        }
        int babyAge = birthDate!.convertFromBirthDateToBabyAge();
        content = '${babyAge~/7} tuần ${babyAge%7} ngày';
        if (babyAge < 0) {
          content = '-';
        }
        break;
      case 4:
        title = 'Ngày còn lại:';
        if (birthDate == null) {
          content = '-';
          break;
        }
        int remainDays = birthDate.convertFromBirthDateToRemainDay();

        content = '$remainDays ngày';
        content = remainDays == 0 ? 'Ngày dự sinh' : content;
        content = remainDays < 0 ? 'Quá ${remainDays.abs()} ngày' : content;

        break;
      case 5:
        title = 'Kỳ kinh cuối:';
        if (birthDate == null) {
          content = '-';
          break;
        }
        DateTime lastPeriod = birthDate.convertFromBirthDateToLastPeriod();
        content = lastPeriod.globalDateFormat();
        break;
      default:
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title).w400().text16().primaryTextColor().ellipsis(),
        Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(content).w600().text16().primaryTextColor().ellipsis(),
            )
        ),
      ],
    );
  }
}