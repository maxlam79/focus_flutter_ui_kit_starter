import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../exports.dart';

class FUIDataTable2 extends StatefulWidget {
  final FUIColorScheme fuiColorScheme;
  final FUIDataTable2Size? fuiDataTable2Size;
  final List<DataColumn> columns;
  final double? width;
  final double? height;
  final int? sortColumnIndex;
  final bool sortAscending;
  final ValueSetter<bool?>? onSelectAll;
  final Decoration? decoration;
  final WidgetStateProperty<Color?>? dataRowColor;
  final double? dataRowHeight;
  final TextStyle? dataTextStyle;
  final WidgetStateProperty<Color?>? headingRowColor;
  final Color? fixedColumnsColor;
  final Color? fixedCornerColor;
  final double? headingRowHeight;
  final TextStyle? headingTextStyle;
  final CheckboxThemeData? headingCheckboxTheme;
  final CheckboxThemeData? datarowCheckboxTheme;
  final double? horizontalMargin;
  final double? checkboxHorizontalMargin;
  final Alignment checkboxAlignment;
  final double? bottomMargin;
  final double? columnSpacing;
  final bool showCheckboxColumn;
  final bool showBottomBorder;
  final double? dividerThickness;
  final Clip clipBehavior;
  final double? minWidth;
  final ScrollController? scrollController;
  final ScrollController? horizontalScrollController;
  final bool? isVerticalScrollBarVisible;
  final bool? isHorizontalScrollBarVisible;
  final String? emptyMsg;
  final Widget? empty;
  final TableBorder? border;
  final double smRatio;
  final double lmRatio;
  final int fixedTopRows;
  final int fixedLeftColumns;
  final Duration sortArrowAnimationDuration;
  final IconData? sortArrowIcon;
  final Widget Function(bool ascending, bool sorted)? sortArrowBuilder;
  final List<DataRow> rows;

  FUIDataTable2({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.fuiDataTable2Size = FUIDataTable2Size.medium,
    required this.columns,
    this.width,
    this.height = FUIDataTable2Theme.tableHeight,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.onSelectAll,
    this.decoration,
    this.dataRowColor,
    this.dataRowHeight,
    this.dataTextStyle,
    this.headingRowColor,
    this.fixedColumnsColor,
    this.fixedCornerColor,
    this.headingRowHeight,
    this.headingTextStyle,
    this.headingCheckboxTheme,
    this.datarowCheckboxTheme,
    this.horizontalMargin = FUIDataTable2Theme.horizontalMargin,
    this.checkboxHorizontalMargin,
    this.checkboxAlignment = Alignment.center,
    this.bottomMargin,
    this.columnSpacing = FUIDataTable2Theme.columnSpacing,
    this.showCheckboxColumn = true,
    this.showBottomBorder = false,
    this.dividerThickness,
    this.clipBehavior = Clip.none,
    this.minWidth,
    this.scrollController,
    this.horizontalScrollController,
    this.isVerticalScrollBarVisible,
    this.isHorizontalScrollBarVisible,
    this.emptyMsg = 'No data available',
    this.empty,
    this.border,
    this.smRatio = 0.67,
    this.fixedTopRows = 1,
    this.fixedLeftColumns = 0,
    this.lmRatio = 1.2,
    this.sortArrowAnimationDuration = const Duration(milliseconds: 150),
    this.sortArrowIcon,
    this.sortArrowBuilder,
    required this.rows,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIDataTable2> createState() => _FUIDataTable2State();
}

class _FUIDataTable2State extends State<FUIDataTable2> with FUIDataTable2Mixin, FUIColorMixin {
  /// Essentials
  late FUIThemeCommonColors fuiColors;
  late FUIDataTable2Theme fuiDataTable2Theme;
  late bool ascending, sorted;

  /// Sorting
  late IconData sortArrowIcon;
  late Widget Function(bool ascending, bool sorted)? sortArrowBuilder;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    fuiDataTable2Theme = context.theme.fuiDataTable2;
    TextStyle headingTs = discernHeadingTextStyle(context, widget.fuiColorScheme, widget.fuiDataTable2Size);
    TextStyle rowTs = discernRowTextStyle(context, widget.fuiDataTable2Size);
    Color headingRowColor = discernColorByScheme(context, fuiColorScheme: widget.fuiColorScheme, fallbackColor: Colors.transparent);

    if (widget.sortArrowIcon == null && widget.sortArrowBuilder == null) {
      sortArrowBuilder = (ascending, sorted) {
        return Stack(
          children: [
            _SortIcon(
              fuiColorScheme: widget.fuiColorScheme,
              fuiDataTable2Size: widget.fuiDataTable2Size,
              ascending: true,
              active: sorted && ascending,
            ),
            Padding(
              padding: FUIDataTable2Theme.sortArrowNextPadding,
              child: _SortIcon(
                ascending: false,
                active: sorted && !ascending,
              ),
            ),
          ],
        );
      };
    } else {
      sortArrowBuilder = widget.sortArrowBuilder;
    }

    sortArrowIcon = CupertinoIcons.arrowtriangle_up_fill;

    return Theme(
      data: context.theme.copyWith(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: WidgetStateProperty.all(headingRowColor),
          thickness: WidgetStateProperty.all(FUIScrollViewTheme.thickness),
          radius: Radius.zero,
        ),
      ),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: DataTable2(
          columns: widget.columns,
          sortColumnIndex: widget.sortColumnIndex,
          sortAscending: widget.sortAscending,
          onSelectAll: (selectAll) {
            if (widget.onSelectAll != null) {
              widget.onSelectAll!(selectAll);
            }
          },
          decoration: widget.decoration,
          dataRowColor: widget.dataRowColor ?? WidgetStateProperty.all(fuiDataTable2Theme.rowColor),
          dataRowHeight: widget.dataRowHeight ?? discernDataRowHeight(widget.fuiDataTable2Size),
          dataTextStyle: widget.dataTextStyle ?? rowTs,
          headingRowColor: widget.headingRowColor ?? WidgetStateColor.resolveWith((states) => headingRowColor),
          fixedColumnsColor: widget.fixedColumnsColor,
          fixedCornerColor: widget.fixedCornerColor,
          headingRowHeight: widget.headingRowHeight ?? discernHeadingRowHeight(widget.fuiDataTable2Size),
          headingTextStyle: widget.headingTextStyle ?? headingTs,
          headingCheckboxTheme: widget.headingCheckboxTheme ?? discernHeadingCheckboxTheme(context, widget.fuiColorScheme, widget.fuiDataTable2Size),
          datarowCheckboxTheme: widget.datarowCheckboxTheme ?? discernRowCheckboxTheme(context, widget.fuiColorScheme),
          horizontalMargin: widget.horizontalMargin,
          checkboxHorizontalMargin: widget.checkboxHorizontalMargin,
          checkboxAlignment: widget.checkboxAlignment,
          bottomMargin: widget.bottomMargin,
          columnSpacing: widget.columnSpacing,
          showCheckboxColumn: widget.showCheckboxColumn,
          showBottomBorder: widget.showBottomBorder,
          dividerThickness: widget.dividerThickness,
          clipBehavior: widget.clipBehavior,
          minWidth: widget.minWidth,
          scrollController: widget.scrollController,
          horizontalScrollController: widget.horizontalScrollController,
          isVerticalScrollBarVisible: widget.isVerticalScrollBarVisible,
          isHorizontalScrollBarVisible: widget.isHorizontalScrollBarVisible,
          empty: widget.empty ?? buildEmptyWidget(context, widget.emptyMsg),
          border: widget.border,
          smRatio: widget.smRatio,
          fixedTopRows: widget.fixedTopRows,
          fixedLeftColumns: widget.fixedLeftColumns,
          lmRatio: widget.lmRatio,
          sortArrowAnimationDuration: widget.sortArrowAnimationDuration,
          sortArrowIcon: sortArrowIcon,
          sortArrowBuilder: sortArrowBuilder,
          rows: widget.rows,
        ),
      ),
    );
  }
}

class FUIPaginatedDataTable2 extends StatefulWidget {
  final FUIColorScheme fuiColorScheme;
  final FUIDataTable2Size? fuiDataTable2Size;
  final List<Widget>? actions;
  final List<DataColumn> columns;
  final double? width;
  final double? height;
  final int? sortColumnIndex;
  final bool sortAscending;
  final Duration sortArrowAnimationDuration;
  final IconData? sortArrowIcon;
  final Widget Function(bool ascending, bool sorted)? sortArrowBuilder;
  final bool sortArrowAlwaysVisible;
  final ValueSetter<bool?>? onSelectAll;
  final double? dataRowHeight;
  final TextStyle? dataTextStyle;
  final double? headingRowHeight;
  final TextStyle? headingTextStyle;
  final CheckboxThemeData? headingCheckboxTheme;
  final CheckboxThemeData? datarowCheckboxTheme;
  final WidgetStateProperty<Color?>? headingRowColor;
  final double horizontalMargin;
  final double columnSpacing;
  final double? dividerThickness;
  final bool renderEmptyRowsInTheEnd;
  final int fixedLeftColumns;
  final int fixedTopRows;
  final Color? fixedColumnsColor;
  final Color? fixedCornerColor;
  final bool showCheckboxColumn;
  final bool showFirstLastButtons;
  final int? initialFirstRowIndex;
  final ValueChanged<int>? onPageChanged;
  final int rowsPerPage;
  final List<int> availableRowsPerPage;
  final ValueChanged<int?>? onRowsPerPageChanged;
  final DragStartBehavior dragStartBehavior;
  final DataTableSource source;
  final double? checkboxHorizontalMargin;
  final Alignment checkboxAlignment;
  final bool wrapInCard;
  final double? minWidth;
  final FlexFit fit;
  final bool hidePaginator;
  final PaginatorController? controller;
  final ScrollController? scrollController;
  final ScrollController? horizontalScrollController;
  final String? emptyMsg;
  final Widget? empty;
  final TableBorder? border;
  final bool autoRowsToHeight;
  final double smRatio;
  final double lmRatio;

  const FUIPaginatedDataTable2({
    super.key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.fuiDataTable2Size = FUIDataTable2Size.medium,
    this.actions,
    required this.columns,
    this.width,
    this.height = FUIDataTable2Theme.tableHeight,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.sortArrowAnimationDuration = const Duration(milliseconds: 150),
    this.sortArrowIcon,
    this.sortArrowBuilder,
    this.sortArrowAlwaysVisible = false,
    this.onSelectAll,
    this.dataRowHeight,
    this.dataTextStyle,
    this.headingRowHeight,
    this.headingRowColor,
    this.headingTextStyle,
    this.headingCheckboxTheme,
    this.datarowCheckboxTheme,
    this.horizontalMargin = FUIDataTable2Theme.horizontalMargin,
    this.columnSpacing = FUIDataTable2Theme.columnSpacing,
    this.dividerThickness,
    this.renderEmptyRowsInTheEnd = false,
    this.fixedLeftColumns = 0,
    this.fixedTopRows = 1,
    this.fixedColumnsColor,
    this.fixedCornerColor,
    this.showCheckboxColumn = true,
    this.showFirstLastButtons = false,
    this.initialFirstRowIndex = 0,
    this.onPageChanged,
    this.rowsPerPage = defaultRowsPerPage,
    this.availableRowsPerPage = const <int>[
      defaultRowsPerPage,
      defaultRowsPerPage * 2,
      defaultRowsPerPage * 5,
      defaultRowsPerPage * 10,
    ],
    this.onRowsPerPageChanged,
    this.dragStartBehavior = DragStartBehavior.start,
    required this.source,
    this.checkboxHorizontalMargin,
    this.checkboxAlignment = Alignment.center,
    this.wrapInCard = true,
    this.minWidth,
    this.fit = FlexFit.tight,
    this.hidePaginator = false,
    this.controller,
    this.scrollController,
    this.horizontalScrollController,
    this.emptyMsg = 'No data available',
    this.empty,
    this.border,
    this.autoRowsToHeight = false,
    this.smRatio = 0.67,
    this.lmRatio = 1.2,
  });

  @override
  State<FUIPaginatedDataTable2> createState() => _FUIPaginatedDataTable2State();
}

class _FUIPaginatedDataTable2State extends State<FUIPaginatedDataTable2> with FUIDataTable2Mixin, FUIColorMixin {
  /// Essentials
  late FUIThemeCommonColors fuiColors;
  late FUIDataTable2Theme fuiDataTable2Theme;

  /// Sorting
  late IconData sortArrowIcon;
  late Widget Function(bool ascending, bool sorted)? sortArrowBuilder;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    fuiDataTable2Theme = context.theme.fuiDataTable2;
    TextStyle headingTs = discernHeadingTextStyle(context, widget.fuiColorScheme, widget.fuiDataTable2Size);
    TextStyle rowTs = discernRowTextStyle(context, widget.fuiDataTable2Size);
    Color headingRowColor = discernColorByScheme(context, fuiColorScheme: widget.fuiColorScheme, fallbackColor: Colors.transparent);

    if (widget.sortArrowIcon == null && widget.sortArrowBuilder == null) {
      sortArrowBuilder = (ascending, sorted) {
        return Stack(
          children: [
            _SortIcon(
              fuiColorScheme: widget.fuiColorScheme,
              fuiDataTable2Size: widget.fuiDataTable2Size,
              ascending: true,
              active: sorted && ascending,
            ),
            Padding(
              padding: FUIDataTable2Theme.sortArrowNextPadding,
              child: _SortIcon(
                ascending: false,
                active: sorted && !ascending,
              ),
            ),
          ],
        );
      };
    } else {
      sortArrowBuilder = widget.sortArrowBuilder;
    }

    sortArrowIcon = CupertinoIcons.arrowtriangle_up_fill;

    return Theme(
      data: context.theme.copyWith(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: WidgetStateProperty.all(headingRowColor),
          thickness: WidgetStateProperty.all(FUIScrollViewTheme.thickness),
          radius: Radius.zero,
        ),
        cardTheme: const CardTheme().copyWith(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          color: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
        buttonTheme: const ButtonThemeData().copyWith(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: const ButtonStyle().copyWith(
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
          ),
        ),
      ),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: PaginatedDataTable2(
          columns: widget.columns,
          actions: widget.actions,
          sortColumnIndex: widget.sortColumnIndex,
          sortAscending: widget.sortAscending,
          sortArrowAnimationDuration: widget.sortArrowAnimationDuration,
          sortArrowIcon: sortArrowIcon,
          sortArrowBuilder: sortArrowBuilder,
          sortArrowAlwaysVisible: widget.sortArrowAlwaysVisible,
          onSelectAll: widget.onSelectAll,
          dataRowHeight: widget.dataRowHeight ?? discernDataRowHeight(widget.fuiDataTable2Size),
          dataTextStyle: widget.dataTextStyle ?? rowTs,
          headingRowHeight: widget.headingRowHeight ?? discernHeadingRowHeight(widget.fuiDataTable2Size),
          headingRowColor: widget.headingRowColor ?? WidgetStateColor.resolveWith((states) => headingRowColor),
          headingTextStyle: widget.headingTextStyle ?? headingTs,
          headingCheckboxTheme: widget.headingCheckboxTheme ?? discernHeadingCheckboxTheme(context, widget.fuiColorScheme, widget.fuiDataTable2Size),
          datarowCheckboxTheme: widget.datarowCheckboxTheme ?? discernRowCheckboxTheme(context, widget.fuiColorScheme),
          horizontalMargin: widget.horizontalMargin,
          columnSpacing: widget.columnSpacing,
          dividerThickness: widget.dividerThickness,
          renderEmptyRowsInTheEnd: widget.renderEmptyRowsInTheEnd,
          fixedLeftColumns: widget.fixedLeftColumns,
          fixedTopRows: widget.fixedTopRows,
          fixedColumnsColor: widget.fixedColumnsColor,
          fixedCornerColor: widget.fixedColumnsColor,
          showCheckboxColumn: widget.showCheckboxColumn,
          showFirstLastButtons: widget.showFirstLastButtons,
          initialFirstRowIndex: widget.initialFirstRowIndex,
          onPageChanged: widget.onPageChanged,
          rowsPerPage: widget.rowsPerPage,
          availableRowsPerPage: widget.availableRowsPerPage,
          onRowsPerPageChanged: widget.onRowsPerPageChanged,
          dragStartBehavior: widget.dragStartBehavior,
          source: widget.source,
          checkboxHorizontalMargin: widget.checkboxHorizontalMargin,
          checkboxAlignment: widget.checkboxAlignment,
          wrapInCard: widget.wrapInCard,
          minWidth: widget.minWidth,
          fit: widget.fit,
          hidePaginator: widget.hidePaginator,
          controller: widget.controller,
          scrollController: widget.scrollController,
          horizontalScrollController: widget.horizontalScrollController,
          empty: widget.empty ?? buildEmptyWidget(context, widget.emptyMsg),
          border: widget.border,
          autoRowsToHeight: widget.autoRowsToHeight,
          smRatio: widget.smRatio,
          lmRatio: widget.lmRatio,
        ),
      ),
    );
  }
}

class FUIAsyncPaginatedDataTable2 extends StatefulWidget {
  final FUIColorScheme fuiColorScheme;
  final FUIDataTable2Size? fuiDataTable2Size;
  final Widget? header;
  final List<Widget>? actions;
  final List<DataColumn> columns;
  final double? width;
  final double? height;
  final int? sortColumnIndex;
  final bool sortAscending;
  final Duration sortArrowAnimationDuration;
  final IconData? sortArrowIcon;
  final Widget Function(bool ascending, bool sorted)? sortArrowBuilder;
  final bool sortArrowAlwaysVisible;
  final ValueSetter<bool?>? onSelectAll;
  final double? dataRowHeight;
  final TextStyle? dataTextStyle;
  final double? headingRowHeight;
  final TextStyle? headingTextStyle;
  final CheckboxThemeData? headingCheckboxTheme;
  final CheckboxThemeData? datarowCheckboxTheme;
  final WidgetStateProperty<Color?>? headingRowColor;
  final double horizontalMargin;
  final double columnSpacing;
  final double? dividerThickness;
  final bool renderEmptyRowsInTheEnd;
  final int fixedLeftColumns;
  final int fixedTopRows;
  final Color? fixedColumnsColor;
  final Color? fixedCornerColor;
  final bool showCheckboxColumn;
  final bool showFirstLastButtons;
  final int? initialFirstRowIndex;
  final ValueChanged<int>? onPageChanged;
  final int rowsPerPage;
  final List<int> availableRowsPerPage;
  final ValueChanged<int?>? onRowsPerPageChanged;
  final DragStartBehavior dragStartBehavior;
  final DataTableSource source;
  final double? checkboxHorizontalMargin;
  final Alignment checkboxAlignment;
  final bool wrapInCard;
  final double? minWidth;
  final FlexFit fit;
  final bool hidePaginator;
  final PaginatorController? controller;
  final ScrollController? scrollController;
  final ScrollController? horizontalScrollController;
  final String? emptyMsg;
  final Widget? empty;
  final Widget? loading;
  final bool loadingBlurBackground;
  final Widget Function(Object? error)? errorBuilder;
  final PageSyncApproach pageSyncApproach;
  final TableBorder? border;
  final bool autoRowsToHeight;
  final double smRatio;
  final double lmRatio;

  const FUIAsyncPaginatedDataTable2({
    super.key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.fuiDataTable2Size = FUIDataTable2Size.medium,
    this.header,
    this.actions,
    required this.columns,
    this.width,
    this.height = FUIDataTable2Theme.tableHeight,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.sortArrowAnimationDuration = const Duration(milliseconds: 150),
    this.sortArrowIcon,
    this.sortArrowAlwaysVisible = false,
    this.sortArrowBuilder,
    this.onSelectAll,
    this.dataRowHeight,
    this.dataTextStyle,
    this.headingRowColor,
    this.headingRowHeight,
    this.headingTextStyle,
    this.headingCheckboxTheme,
    this.datarowCheckboxTheme,
    this.horizontalMargin = FUIDataTable2Theme.horizontalMargin,
    this.columnSpacing = FUIDataTable2Theme.columnSpacing,
    this.dividerThickness,
    this.renderEmptyRowsInTheEnd = false,
    this.fixedLeftColumns = 0,
    this.fixedTopRows = 1,
    this.fixedColumnsColor,
    this.fixedCornerColor,
    this.showCheckboxColumn = true,
    this.showFirstLastButtons = false,
    this.initialFirstRowIndex = 0,
    this.onPageChanged,
    this.rowsPerPage = defaultRowsPerPage,
    this.availableRowsPerPage = const <int>[defaultRowsPerPage, defaultRowsPerPage * 2, defaultRowsPerPage * 5, defaultRowsPerPage * 10],
    this.onRowsPerPageChanged,
    this.dragStartBehavior = DragStartBehavior.start,
    required this.source,
    this.checkboxHorizontalMargin,
    this.checkboxAlignment = Alignment.center,
    this.wrapInCard = true,
    this.minWidth,
    this.fit = FlexFit.tight,
    this.hidePaginator = false,
    this.controller,
    this.scrollController,
    this.horizontalScrollController,
    this.emptyMsg,
    this.empty,
    this.loading,
    this.loadingBlurBackground = true,
    this.errorBuilder,
    this.pageSyncApproach = PageSyncApproach.doNothing,
    this.border,
    this.autoRowsToHeight = false,
    this.smRatio = 0.67,
    this.lmRatio = 1.2,
  });

  @override
  State<FUIAsyncPaginatedDataTable2> createState() => _FUIAsyncPaginatedDataTable2State();
}

class _FUIAsyncPaginatedDataTable2State extends State<FUIAsyncPaginatedDataTable2> with FUIDataTable2Mixin, FUIColorMixin {
  /// Themes
  late FUIThemeCommonColors fuiColors;
  late FUIDataTable2Theme fuiDataTable2Theme;

  /// Bloc
  late FUISpinnerController spinnerCtrl;

  /// Sorting
  late IconData sortArrowIcon;
  late Widget Function(bool ascending, bool sorted)? sortArrowBuilder;

  @override
  void initState() {
    super.initState();

    _initBloc();
  }

  _initBloc() {
    spinnerCtrl = FUISpinnerController(spinnerShow: true);
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    fuiDataTable2Theme = context.theme.fuiDataTable2;

    TextStyle headingTs = discernHeadingTextStyle(context, widget.fuiColorScheme, widget.fuiDataTable2Size);
    TextStyle rowTs = discernRowTextStyle(context, widget.fuiDataTable2Size);
    Color headingRowColor = discernColorByScheme(context, fuiColorScheme: widget.fuiColorScheme, fallbackColor: Colors.transparent);

    if (widget.sortArrowIcon == null && widget.sortArrowBuilder == null) {
      sortArrowBuilder = (ascending, sorted) {
        return Stack(
          children: [
            _SortIcon(
              fuiColorScheme: widget.fuiColorScheme,
              fuiDataTable2Size: widget.fuiDataTable2Size,
              ascending: true,
              active: sorted && ascending,
            ),
            Padding(
              padding: FUIDataTable2Theme.sortArrowNextPadding,
              child: _SortIcon(
                ascending: false,
                active: sorted && !ascending,
              ),
            ),
          ],
        );
      };
    } else {
      sortArrowBuilder = widget.sortArrowBuilder;
    }

    sortArrowIcon = CupertinoIcons.arrowtriangle_up_fill;

    return Theme(
      data: context.theme.copyWith(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: WidgetStateProperty.all(headingRowColor),
          thickness: WidgetStateProperty.all(FUIScrollViewTheme.thickness),
          radius: Radius.zero,
        ),
        cardTheme: const CardTheme().copyWith(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          color: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
        buttonTheme: const ButtonThemeData().copyWith(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: const ButtonStyle().copyWith(
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
          ),
        ),
      ),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: AsyncPaginatedDataTable2(
          header: widget.header,
          columns: widget.columns,
          actions: widget.actions,
          sortColumnIndex: widget.sortColumnIndex,
          sortAscending: widget.sortAscending,
          sortArrowAnimationDuration: widget.sortArrowAnimationDuration,
          sortArrowIcon: sortArrowIcon,
          sortArrowBuilder: sortArrowBuilder,
          sortArrowAlwaysVisible: widget.sortArrowAlwaysVisible,
          onSelectAll: (selectAll) {
            if (widget.onSelectAll != null) {
              widget.onSelectAll!(selectAll);
            }
          },
          dataRowHeight: widget.dataRowHeight ?? discernDataRowHeight(widget.fuiDataTable2Size),
          dataTextStyle: widget.dataTextStyle ?? rowTs,
          headingRowHeight: widget.headingRowHeight ?? discernHeadingRowHeight(widget.fuiDataTable2Size),
          headingRowColor: widget.headingRowColor ?? WidgetStateColor.resolveWith((states) => headingRowColor),
          headingTextStyle: widget.headingTextStyle ?? headingTs,
          headingCheckboxTheme: widget.headingCheckboxTheme ?? discernHeadingCheckboxTheme(context, widget.fuiColorScheme, widget.fuiDataTable2Size),
          datarowCheckboxTheme: widget.datarowCheckboxTheme ?? discernRowCheckboxTheme(context, widget.fuiColorScheme),
          horizontalMargin: widget.horizontalMargin,
          columnSpacing: widget.columnSpacing,
          dividerThickness: widget.dividerThickness,
          renderEmptyRowsInTheEnd: widget.renderEmptyRowsInTheEnd,
          fixedLeftColumns: widget.fixedLeftColumns,
          fixedTopRows: widget.fixedTopRows,
          fixedColumnsColor: widget.fixedColumnsColor,
          fixedCornerColor: widget.fixedColumnsColor,
          showCheckboxColumn: widget.showCheckboxColumn,
          showFirstLastButtons: widget.showFirstLastButtons,
          initialFirstRowIndex: widget.initialFirstRowIndex,
          onPageChanged: widget.onPageChanged,
          rowsPerPage: widget.rowsPerPage,
          availableRowsPerPage: widget.availableRowsPerPage,
          onRowsPerPageChanged: widget.onRowsPerPageChanged,
          dragStartBehavior: widget.dragStartBehavior,
          source: widget.source,
          checkboxHorizontalMargin: widget.checkboxHorizontalMargin,
          checkboxAlignment: widget.checkboxAlignment,
          wrapInCard: widget.wrapInCard,
          minWidth: widget.minWidth,
          fit: widget.fit,
          hidePaginator: widget.hidePaginator,
          controller: widget.controller,
          scrollController: widget.scrollController,
          horizontalScrollController: widget.horizontalScrollController,
          empty: widget.empty ?? buildEmptyWidget(context, widget.emptyMsg),
          loading: widget.loading ?? _buildLoadingWidget(),
          errorBuilder: widget.errorBuilder,
          pageSyncApproach: widget.pageSyncApproach,
          border: widget.border,
          autoRowsToHeight: widget.autoRowsToHeight,
          smRatio: widget.smRatio,
          lmRatio: widget.lmRatio,
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    if (widget.loading != null) {
      if (widget.loadingBlurBackground) {
        return Stack(
          children: [
            Container(
              color: fuiDataTable2Theme.spinnerBarrierColor,
            ),
            Center(child: widget.loading!),
          ],
        );
      } else {
        return Expanded(
          child: Center(child: widget.loading!),
        );
      }
    } else {
      if (widget.loadingBlurBackground) {
        return Stack(
          children: [
            Container(
              color: fuiDataTable2Theme.spinnerBarrierColor,
            ),
            Center(
              child: FUISpinner(
                fuiColorScheme: widget.fuiColorScheme,
                rotationEnable: true,
              ),
            ),
          ],
        );
      } else {
        return Expanded(
          child: Center(
            child: FUISpinner(
              fuiColorScheme: widget.fuiColorScheme,
              rotationEnable: true,
            ),
          ),
        );
      }
    }
  }
}

class _SortIcon extends StatelessWidget {
  final FUIColorScheme fuiColorScheme;
  final FUIDataTable2Size? fuiDataTable2Size;
  final bool ascending;
  final bool active;

  const _SortIcon({
    this.fuiColorScheme = FUIColorScheme.primary,
    this.fuiDataTable2Size = FUIDataTable2Size.medium,
    required this.ascending,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    FUIThemeCommonColors fuiColors = context.theme.fuiColors;
    Color iconColor;

    switch (fuiColorScheme) {
      case FUIColorScheme.primary:
      case FUIColorScheme.secondary:
      case FUIColorScheme.ruby:
      case FUIColorScheme.tartOrange:
      case FUIColorScheme.opal:
      case FUIColorScheme.purple:
      case FUIColorScheme.berry:
      case FUIColorScheme.cobalt:
      case FUIColorScheme.teal:
      case FUIColorScheme.black:
      case FUIColorScheme.denim:
      case FUIColorScheme.prussian:
      case FUIColorScheme.success:
      case FUIColorScheme.complete:
      case FUIColorScheme.error:
        iconColor = fuiColors.shade0;
        break;
      case FUIColorScheme.papayaWhip:
      case FUIColorScheme.bumbleBee:
      case FUIColorScheme.lightGrey:
      case FUIColorScheme.banana:
      case FUIColorScheme.warning:
        iconColor = fuiColors.secondary;
        break;
      default:
        iconColor = fuiColors.shade0;
        break;
    }

    double iconSize;

    switch (fuiDataTable2Size) {
      case FUIDataTable2Size.small:
        iconSize = FUIDataTable2Theme.sortArrowSizeSmall;
        break;
      case FUIDataTable2Size.large:
        iconSize = FUIDataTable2Theme.sortArrowSizeLarge;
        break;
      case FUIDataTable2Size.medium:
      default:
        iconSize = FUIDataTable2Theme.sortArrowSizeMedium;
        break;
    }

    return Icon(
      ascending ? CupertinoIcons.arrowtriangle_up_fill : CupertinoIcons.arrowtriangle_down_fill,
      size: iconSize,
      color: active ? iconColor : iconColor.withValues(alpha: FUIDataTable2Theme.sortArrowInactiveOpacity),
    );
  }
}
