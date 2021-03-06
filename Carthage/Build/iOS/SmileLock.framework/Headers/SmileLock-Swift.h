// Generated by Apple Swift version 3.1 (swiftlang-802.0.53 clang-802.0.42)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if defined(__has_attribute) && __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreGraphics;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"

@interface NSLayoutConstraint (SWIFT_EXTENSION(SmileLock))
@end

@class PasswordInputView;
@class PasswordDotView;
@class UIColor;
@class UIViewController;
@class UIStackView;
@class NSCoder;

SWIFT_CLASS("_TtC9SmileLock21PasswordContainerView")
@interface PasswordContainerView : UIView
@property (nonatomic, copy) IBOutletCollection(PasswordInputView) NSArray<PasswordInputView *> * _Null_unspecified passwordInputViews;
@property (nonatomic, weak) IBOutlet PasswordDotView * _Null_unspecified passwordDotView;
@property (nonatomic, copy) NSString * _Nonnull deleteButtonLocalizedTitle;
@property (nonatomic) BOOL isVibrancyEffect;
@property (nonatomic, strong) UIColor * _Null_unspecified tintColor;
@property (nonatomic, strong) UIColor * _Null_unspecified highlightedColor;
@property (nonatomic, readonly) BOOL isTouchAuthenticationAvailable;
@property (nonatomic) BOOL touchAuthenticationEnabled;
@property (nonatomic, copy) NSString * _Nonnull touchAuthenticationReason;
@property (nonatomic) CGFloat width;
- (void)rearrangeForVisualEffectViewIn:(UIViewController * _Nonnull)vc;
+ (PasswordContainerView * _Nonnull)createWithDigit:(NSInteger)digit SWIFT_WARN_UNUSED_RESULT;
+ (PasswordContainerView * _Nonnull)createIn:(UIStackView * _Nonnull)stackView digit:(NSInteger)digit SWIFT_WARN_UNUSED_RESULT;
- (void)awakeFromNib;
- (void)wrongPassword;
- (void)clearInput;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface PasswordContainerView (SWIFT_EXTENSION(SmileLock))
- (void)passwordInputView:(PasswordInputView * _Nonnull)passwordInputView tappedString:(NSString * _Nonnull)tappedString;
@end


@interface PasswordContainerView (SWIFT_EXTENSION(SmileLock))
@end


SWIFT_CLASS("_TtC9SmileLock15PasswordDotView")
@interface PasswordDotView : UIView
@property (nonatomic) NSInteger inputDotCount;
@property (nonatomic) NSInteger totalDotCount;
@property (nonatomic, strong) UIColor * _Nonnull strokeColor;
@property (nonatomic, strong) UIColor * _Nonnull fillColor;
@property (nonatomic, readonly) BOOL isFull;
- (void)drawRect:(CGRect)rect;
- (void)awakeFromNib;
- (void)layoutSubviews;
- (void)shakeAnimationWithCompletion:(void (^ _Nonnull)(void))completion;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface PasswordDotView (SWIFT_EXTENSION(SmileLock))
@end

@class UILabel;

SWIFT_CLASS("_TtC9SmileLock17PasswordInputView")
@interface PasswordInputView : UIView
@property (nonatomic, readonly, strong) UILabel * _Nonnull label;
@property (nonatomic, readonly) BOOL isAnimating;
@property (nonatomic, copy) NSString * _Nonnull numberString;
@property (nonatomic, strong) UIColor * _Nonnull borderColor;
@property (nonatomic, strong) UIColor * _Nonnull circleBackgroundColor;
@property (nonatomic, strong) UIColor * _Nonnull textColor;
@property (nonatomic, strong) UIColor * _Nonnull highlightBackgroundColor;
@property (nonatomic, strong) UIColor * _Nonnull highlightTextColor;
- (void)awakeFromNib;
- (void)layoutSubviews;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface PasswordInputView (SWIFT_EXTENSION(SmileLock))
@end


@interface UIBezierPath (SWIFT_EXTENSION(SmileLock))
@end

#pragma clang diagnostic pop
