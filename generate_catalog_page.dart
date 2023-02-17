import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:empresa_app/flavors/flavors.dart';
import 'package:empresa_app/modules/seller_module/presenter/pages/generate_catalog/generate_catalog_store.dart';
import 'package:empresa_app/modules/seller_module/presenter/utils/enums/catalog_cover_enum.dart';
import 'package:empresa_app/modules/seller_module/presenter/utils/enums/order_catalog_by_enum.dart';
import 'package:empresa_app/modules/seller_module/presenter/utils/enums/price_B2b_B2c_enum.dart';
import 'package:empresa_app/modules/seller_module/presenter/utils/enums/tags_catalog_generate.dart';
import 'package:empresa_app/shared/components/app_bar/custom_app_bar.dart';
import 'package:empresa_app/shared/components/buttons/primary_elevated_button.dart';
import 'package:empresa_app/shared/components/form_fields/custom_text_form_fields.dart';
import 'package:empresa_app/shared/constants/strings.dart';

class GenerateCatalogPage extends StatefulWidget {
  const GenerateCatalogPage({Key? key}) : super(key: key);

  @override
  State<GenerateCatalogPage> createState() => _GenerateCatalogPageState();
}

class _GenerateCatalogPageState extends State<GenerateCatalogPage> {
  final GenerateCatalogStore _store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: F.colors.secondary,
      appBar: CustomAppBar.primary(
        context,
        title: AppTitles.generateCatalog,
        actions: [],
      ),
      persistentFooterButtons: [
        _buildGenerateCatalog(),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCatalogNameTextField(),
            _buildCoverBySegmentList(),
            _buildPriceList(),
            _buildTagsList(),
            const SizedBox(height: 20),
            _buildIncludeBarCodeIncludeNcm(),
            _buildIncludeQuantityBox(),
            _buildOrderCatalogBy(),
          ],
        ),
      ),
    );
  }

  Widget _buildCatalogNameTextField() {
    return CustomTextFormField(
      label: AppStrings.enterTheCatalogName,
      onChanged: _store.setCatalogName,
    );
  }

  Widget _buildCoverBySegmentList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(AppStrings.coverBySegment,
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        Observer(builder: (context) {
          return SizedBox(
            height: 128,
            child: Wrap(
              direction: Axis.vertical,
              runSpacing: 32,
              alignment: WrapAlignment.start,
              children: CatalogCover.values
                  .map((e) => InkWell(
                        onTap: () => _store.setCatalogCover(e),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            children: [
                              Radio<CatalogCover>(
                                value: e,
                                groupValue: _store.catalogCover,
                                onChanged: _store.setCatalogCover,
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                              Text(
                                e.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
        })
      ],
    );
  }

  Widget _buildPriceList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(AppStrings.price,
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        Observer(builder: (context) {
          return Row(
            children: PriceB2bB2c.values
                .map((e) => Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: InkWell(
                        onTap: () {
                          if (!_store.priceB2bB2cList.contains(e)) {
                            _store.addPriceB2bB2c(e);
                          } else {
                            _store.removePriceB2bB2c(e);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            children: [
                              Checkbox(
                                value: _store.priceB2bB2cList.contains(e),
                                onChanged: (value) {
                                  if (value != null && value) {
                                    _store.addPriceB2bB2c(e);
                                  } else {
                                    _store.removePriceB2bB2c(e);
                                  }
                                },
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                              Text(
                                e.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          );
        }),
      ],
    );
  }

  Widget _buildTagsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(AppStrings.tags, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        Observer(builder: (context) {
          return SizedBox(
            height: 68,
            width: double.infinity,
            child: Wrap(
              direction: Axis.vertical,
              runSpacing: 19,
              children: TagsCatalogGenerate.values
                  .map((e) => InkWell(
                        onTap: () {
                          if (!_store.tagsCatalogGenerateList.contains(e)) {
                            _store.addTagsCatalogGenerate(e);
                          } else {
                            _store.removeTagsCatalogGenerate(e);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            children: [
                              Checkbox(
                                value:
                                    _store.tagsCatalogGenerateList.contains(e),
                                onChanged: (value) {
                                  if (value != null && value) {
                                    _store.addTagsCatalogGenerate(e);
                                  } else {
                                    _store.removeTagsCatalogGenerate(e);
                                  }
                                },
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                              Text(
                                e.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildIncludeBarCodeIncludeNcm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.includeBarCode,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Observer(builder: (_) {
              return radioYesNo(
                  _store.inlcudeBarCode, _store.setIncludeBarCode);
            }),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.includeNCM,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Observer(builder: (_) {
              return radioYesNo(_store.inlcudeNcm, _store.setInlcudeNcm);
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildIncludeQuantityBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 22),
        Text(AppStrings.includeQuantityBox,
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 17),
        Observer(builder: (_) {
          return radioYesNo(
              _store.includeQuantityBox, _store.setIncludeQuantityBox);
        }),
      ],
    );
  }

  Widget _buildOrderCatalogBy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(AppStrings.orderBytwopoints,
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        Observer(builder: (context) {
          return Row(
            children: OrderCatalogBy.values
                .map((e) => Padding(
                      padding: const EdgeInsets.only(right: 32),
                      child: InkWell(
                        onTap: () => _store.setOrderCatalogBy(e),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            children: [
                              Radio<OrderCatalogBy>(
                                value: e,
                                groupValue: _store.orderCatalogBy,
                                onChanged: _store.setOrderCatalogBy,
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                              Text(
                                e.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          );
        }),
      ],
    );
  }

  Widget _buildGenerateCatalog() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: PrimaryElevatedButton(
          onPressed: () {},
          child: Text(
            AppTitles.generateCatalog.toUpperCase(),
          )),
    );
  }

  Row radioYesNo(bool? storeObservable, dynamic storeSetobservable) {
    return Row(
      children: [
        InkWell(
          onTap: () => storeSetobservable!(true),
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: storeObservable,
                  onChanged: storeSetobservable,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                Text(
                  AppStrings.yes,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        InkWell(
          onTap: () => storeSetobservable(false),
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                Radio<bool>(
                  value: false,
                  groupValue: storeObservable,
                  onChanged: storeSetobservable,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                Text(
                  AppStrings.no,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
