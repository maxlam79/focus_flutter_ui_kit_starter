import 'package:flutter/material.dart';

import '../../exports.dart';

class PreH extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  PreH(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.preH,
      padding: padding ?? FUITypographyTheme.fontPaddingH1,
    );
  }
}

class PreHI extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  PreHI(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.preH.copyWith(
        fontStyle: FontStyle.italic,
      ),
      padding: padding ?? FUITypographyTheme.fontPaddingH1,
    );
  }
}

class H1 extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  H1(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.h1,
      padding: padding ?? FUITypographyTheme.fontPaddingH1,
    );
  }
}

class H1I extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  H1I(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.h1.copyWith(
        fontStyle: FontStyle.italic,
      ),
      padding: padding ?? FUITypographyTheme.fontPaddingH1,
    );
  }
}

class H2 extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  H2(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.h2,
      padding: padding ?? FUITypographyTheme.fontPaddingH2,
    );
  }
}

class H2I extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  H2I(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.h2.copyWith(
        fontStyle: FontStyle.italic,
      ),
      padding: padding ?? FUITypographyTheme.fontPaddingH2,
    );
  }
}

class H3 extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  H3(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.h3,
      padding: padding ?? FUITypographyTheme.fontPaddingH3,
    );
  }
}

class H3I extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  H3I(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.h3.copyWith(
        fontStyle: FontStyle.italic,
      ),
      padding: padding ?? FUITypographyTheme.fontPaddingH3,
    );
  }
}

class H4 extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  H4(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.h4,
      padding: padding ?? FUITypographyTheme.fontPaddingH4,
    );
  }
}

class H4I extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  H4I(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.h4.copyWith(
        fontStyle: FontStyle.italic,
      ),
      padding: padding ?? FUITypographyTheme.fontPaddingH4,
    );
  }
}

class H5 extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  H5(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.h5,
      padding: padding ?? FUITypographyTheme.fontPaddingH5,
    );
  }
}

class H5I extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  H5I(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.h5.copyWith(
        fontStyle: FontStyle.italic,
      ),
      padding: padding ?? FUITypographyTheme.fontPaddingH5,
    );
  }
}

class Regular extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  Regular(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.regular,
      padding: padding ?? FUITypographyTheme.fontPaddingRegular,
    );
  }
}

class RegularI extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  RegularI(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.regular.copyWith(
        fontStyle: FontStyle.italic,
      ),
      padding: padding ?? FUITypographyTheme.fontPaddingRegular,
    );
  }
}

class RegularB extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final AlignmentGeometry? alignment;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  RegularB(
    this.text, {
    Key? key,
    this.alignment,
    this.margin,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.regular.copyWith(
        fontWeight: FontWeight.bold,
      ),
      padding: padding ?? FUITypographyTheme.fontPaddingRegular,
    );
  }
}

class RegularBI extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  RegularBI(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.regular.copyWith(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
      padding: padding ?? FUITypographyTheme.fontPaddingRegular,
    );
  }
}

class SmallText extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  SmallText(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.smallText,
      padding: padding ?? FUITypographyTheme.fontPaddingSmallText,
    );
  }
}

class SmallTextI extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  SmallTextI(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.smallText.copyWith(
        fontStyle: FontStyle.italic,
      ),
      padding: padding ?? FUITypographyTheme.fontPaddingSmallText,
    );
  }
}

class SmallTextB extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  SmallTextB(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.smallText.copyWith(
        fontWeight: FontWeight.bold,
      ),
      padding: padding ?? FUITypographyTheme.fontPaddingSmallText,
    );
  }
}

class SmallTextBI extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  SmallTextBI(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.smallText.copyWith(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
      padding: padding ?? FUITypographyTheme.fontPaddingSmallText,
    );
  }
}

class Highlight extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  Highlight(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.highlight,
      padding: padding ?? FUITypographyTheme.fontPaddingRegular,
    );
  }
}

class HighlightI extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  HighlightI(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.highlight.copyWith(
        fontStyle: FontStyle.italic,
      ),
      padding: padding ?? FUITypographyTheme.fontPaddingRegular,
    );
  }
}

class FieldLabel extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  FieldLabel(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.fieldLabel,
      padding: padding ?? FUITypographyTheme.fontPaddingRegular,
    );
  }
}

class FieldLabelI extends StatelessWidget with FUITypographyHelper {
  final Widget text;
  final EdgeInsets? padding;

  FieldLabelI(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;

    return generate(
      text: text,
      textStyle: typoTheme.fieldLabel.copyWith(
        fontStyle: FontStyle.italic,
      ),
      padding: padding ?? FUITypographyTheme.fontPaddingRegular,
    );
  }
}
