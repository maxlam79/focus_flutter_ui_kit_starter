import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

enum FUIAnimationType {
  bounce,
  flash,
  headShake,
  heartBeat,
  jello,
  pulse,
  rubberBand,
  shake,
  swing,
  tada,
  wobble,
  bounceIn,
  bounceInDown,
  bounceInLeft,
  bounceInRight,
  bounceInUp,
  bounceOut,
  bounceOutDown,
  bounceOutLeft,
  bounceOutRight,
  bounceOutUp,
  fadeIn,
  fadeInDown,
  fadeInDownBig,
  fadeInLeft,
  fadeInLeftBig,
  fadeInRight,
  fadeInRightBig,
  fadeInUp,
  fadeInUpBig,
  fadeOut,
  fadeOutDown,
  fadeOutDownBig,
  fadeOutLeft,
  fadeOutLeftBig,
  fadeOutRight,
  fadeOutRightBig,
  fadeOutUp,
  fadeOutUpBig,
  flip,
  flipInX,
  flipInY,
  flipOutX,
  flipOutY,
  lightSpeedIn,
  lightSpeedOut,
  rotateIn,
  rotateInDownLeft,
  rotateInDownRight,
  rotateInUpLeft,
  rotateInUpRight,
  rotateOut,
  rotateOutDownLeft,
  rotateOutDownRight,
  rotateOutUpLeft,
  rotateOutUpRight,
  slideInDown,
  slideInLeft,
  slideInRight,
  slideInUp,
  slideOutDown,
  slideOutLeft,
  slideOutRight,
  slideOutUp,
  slitInDiagonal,
  slitInHorizontal,
  slitInVertical,
  slitOutDiagonal,
  slitOutHorizontal,
  slitOutVertical,
  hinge,
  jackInTheBox,
  rollIn,
  rollOut,
  zoomIn,
  zoomInDown,
  zoomInLeft,
  zoomInRight,
  zoomInUp,
  zoomOut,
  zoomOutDown,
  zoomOutLeft,
  zoomOutRight,
  zoomOutUp,
}

class FUIAnimationHelper {
  static AnimatorWidget discernAnimator({
    Key? key,
    required FUIAnimationType fuiAnimationType,
    required Widget child,
    AnimationPreferences? preferences,
  }) {
    switch (fuiAnimationType) {
      case FUIAnimationType.bounce:
        return Bounce(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.flash:
        return Flash(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.headShake:
        return HeadShake(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.heartBeat:
        return HeartBeat(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.jello:
        return Jello(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.pulse:
        return Pulse(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.rubberBand:
        return RubberBand(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.shake:
        return Shake(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.swing:
        return Swing(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.tada:
        return Tada(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.wobble:
        return Wobble(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.bounceIn:
        return BounceIn(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.bounceInDown:
        return BounceInDown(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.bounceInLeft:
        return BounceInLeft(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.bounceInRight:
        return BounceInRight(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.bounceInUp:
        return BounceInUp(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.bounceOut:
        return BounceOut(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.bounceOutDown:
        return BounceOutDown(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.bounceOutLeft:
        return BounceOutLeft(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.bounceOutRight:
        return BounceOutRight(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.bounceOutUp:
        return BounceOutUp(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeIn:
        return FadeIn(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeInDown:
        return FadeInDown(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeInDownBig:
        return FadeInDownBig(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeInLeft:
        return FadeInLeft(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeInLeftBig:
        return FadeInLeftBig(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeInRight:
        return FadeInRight(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeInRightBig:
        return FadeInRightBig(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeInUp:
        return FadeInUp(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeInUpBig:
        return FadeInUpBig(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeOut:
        return FadeOut(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeOutDown:
        return FadeOutDown(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeOutDownBig:
        return FadeOutDownBig(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeOutLeft:
        return FadeOutLeft(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeOutLeftBig:
        return FadeOutLeftBig(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeOutRight:
        return FadeOutRight(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeOutRightBig:
        return FadeOutRightBig(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeOutUp:
        return FadeOutUp(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.fadeOutUpBig:
        return FadeOutUpBig(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.flip:
        return Flip(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.flipInX:
        return FlipInX(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.flipInY:
        return FlipInY(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.flipOutX:
        return FlipOutX(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.flipOutY:
        return FlipOutY(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.lightSpeedIn:
        return LightSpeedIn(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.lightSpeedOut:
        return LightSpeedOut(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.rotateIn:
        return RotateIn(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.rotateInDownLeft:
        return RotateInDownLeft(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.rotateInDownRight:
        return RotateInDownRight(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.rotateInUpLeft:
        return RotateInUpLeft(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.rotateInUpRight:
        return RotateInUpRight(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.rotateOut:
        return RotateOut(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.rotateOutDownLeft:
        return RotateOutDownLeft(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.rotateOutDownRight:
        return RotateOutDownRight(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.rotateOutUpLeft:
        return RotateOutUpLeft(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.rotateOutUpRight:
        return RotateOutUpRight(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.slideInDown:
        return SlideInDown(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.slideInLeft:
        return SlideInLeft(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.slideInRight:
        return SlideInRight(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.slideInUp:
        return SlideInUp(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.slideOutDown:
        return SlideOutDown(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.slideOutLeft:
        return SlideOutLeft(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.slideOutRight:
        return SlideOutRight(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.slideOutUp:
        return SlideOutUp(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.slitInDiagonal:
        return SlitInDiagonal(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.slitInHorizontal:
        return SlitInHorizontal(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.slitInVertical:
        return SlitInVertical(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.slitOutDiagonal:
        return SlitOutDiagonal(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.slitOutHorizontal:
        return SlitOutHorizontal(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.slitOutVertical:
        return SlitOutVertical(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.hinge:
        return Hinge(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.jackInTheBox:
        return JackInTheBox(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.rollIn:
        return RollIn(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.rollOut:
        return RollOut(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.zoomIn:
        return ZoomIn(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.zoomInDown:
        return ZoomInDown(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.zoomInLeft:
        return ZoomInLeft(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.zoomInRight:
        return ZoomInRight(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.zoomInUp:
        return ZoomInUp(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.zoomOut:
        return ZoomOut(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.zoomOutDown:
        return ZoomOutDown(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.zoomOutLeft:
        return ZoomOutLeft(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.zoomOutRight:
        return ZoomOutRight(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      case FUIAnimationType.zoomOutUp:
        return ZoomOutUp(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
      default:
        return FadeInDown(key: key, preferences: preferences ?? const AnimationPreferences(), child: child);
    }
  }
}
