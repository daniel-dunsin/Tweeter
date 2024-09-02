import 'package:client/config/routes.dart';
import 'package:client/modules/categories/bloc/categories_bloc.dart';
import 'package:client/modules/categories/models/category_model.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/index.dart';
import 'package:client/shared/utils/network.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/cancel_appbar_leading.dart';
import 'package:client/shared/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectInterestScreen extends StatefulWidget {
  const SelectInterestScreen({super.key});

  @override
  State<SelectInterestScreen> createState() => _SelectInterestScreenState();
}

class _SelectInterestScreenState extends State<SelectInterestScreen> {
  List<CategoryModel> allCategories = [];
  List<String> selectedSubcategories = [];

  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().add(CategoriesRequested());
  }

  void toggleSubCategory(String id) {
    if (selectedSubcategories.contains(id)) {
      setState(() {
        selectedSubcategories.remove(id);
      });
    } else {
      setState(() {
        selectedSubcategories.add(id);
      });
    }
  }

  void submit() {
    context.read<CategoriesBloc>().add(
          SelectInterestsRequested(selectedSubcategories),
        );
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return Scaffold(
      appBar: AppBar(
        actions: [
          SkipAppBarAction()
        ],
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 50,
      ),
      body: Padding(
        padding: CustomTheme.majorScreenPadding,
        child: BlocConsumer<CategoriesBloc, CategoriesState>(
          listener: (context, state) {
            if (state is GetCategoriesSuccess) {
              setState(() {
                allCategories = state.categories;
              });
            }
            if (state is SelectInterestSuccess) {
              handleSuccess("Interests selected");
              setState(() {
                selectedSubcategories = [];
              });
              Navigator.pushNamedAndRemoveUntil(
                context,
                PrivateRoutes.rootHome,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "What are you interested in? ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
                Text("Select some topics you're interested in to help personalize your Tweeter experience, starting with finding people to follow"),
                const SizedBox(height: 30),
                Expanded(
                  child: Visibility(
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: allCategories.map(
                            (category) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Wrap(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.start,
                                    spacing: 10,
                                    runSpacing: 5,
                                    children: category.subCategories.map(
                                      (sub) {
                                        final bool selected = selectedSubcategories.contains(sub.id);

                                        return ChoiceChip(
                                          selected: selected,
                                          label: Text(sub.name),
                                          color: WidgetStatePropertyAll(!selected ? appColors.backgroundColor : appColors.iconColor),
                                          labelStyle: TextStyle(
                                            color: selected ? TweeterColors.white : appColors.iconColor,
                                          ),
                                          showCheckmark: false,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                            side: BorderSide(
                                              color: appColors.iconColor,
                                              width: 2,
                                            ),
                                          ),
                                          onSelected: (selected) {
                                            toggleSubCategory(sub.id);
                                          },
                                        );
                                      },
                                    ).toList(),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                    replacement: TweeterLoader(),
                    visible: state is! GetCategoriesLoading,
                  ),
                ),
                Card(
                  elevation: 3,
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ContainedButton(
                      child: Text("Done"),
                      onPressed: () {
                        submit();
                      },
                      fullWidth: true,
                      loading: state is SelectInterestLoading,
                      disabled: selectedSubcategories.isEmpty,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
