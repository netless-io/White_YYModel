//
//  YYTestClassInfo.m
//  YYModel <https://github.com/ibireme/YYModel>
//
//  Created by ibireme on 15/11/27.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <XCTest/XCTest.h>
#import <CoreFoundation/CoreFoundation.h>
#import "White_YYModel.h"

typedef union yy_union{ char a; int b;} yy_union;

@interface YYTestPropertyModel : NSObject
@property bool boolValue;
@property BOOL BOOLValue;
@property char charValue;
@property unsigned char unsignedCharValue;
@property short shortValue;
@property unsigned short unsignedShortValue;
@property int intValue;
@property unsigned int unsignedIntValue;
@property long longValue;
@property unsigned long unsignedLongValue;
@property long long longLongValue;
@property unsigned long long unsignedLongLongValue;
@property float floatValue;
@property double doubleValue;
@property long double longDoubleValue;
@property (strong) NSObject *objectValue;
@property (strong) NSArray *arrayValue;
@property (strong) Class classValue;
@property SEL selectorValue;
@property (copy) void (^blockValue)();
@property void *pointerValue;
@property CFArrayEqualCallBack functionPointerValue;
@property CGRect structValue;
@property yy_union unionValue;
@property char *cStringValue;

@property (nonatomic) NSObject *nonatomicValue;
@property (copy) NSObject *aCopyValue;
@property (assign) NSObject *assignValue;
@property (strong) NSObject *strongValue;
@property (retain) NSObject *retainValue;
@property (weak) NSObject *weakValue;
@property (readonly) NSObject *readonlyValue;
@property (nonatomic) NSObject *dynamicValue;
@property (unsafe_unretained) NSObject *unsafeValue;
@property (nonatomic, getter=getValue) NSObject *getterValue;
@property (nonatomic, setter=setValue:) NSObject *setterValue;
@end

@implementation YYTestPropertyModel {
    const NSObject *_constValue;
}

@dynamic dynamicValue;

- (NSObject *)getValue {
    return _getterValue;
}

- (void)setValue:(NSObject *)value {
    _setterValue = value;
}

- (void)testConst:(const NSObject *)value {}
- (void)testIn:(in NSObject *)value {}
- (void)testOut:(out NSObject *)value {}
- (void)testInout:(inout NSObject *)value {}
- (void)testBycopy:(bycopy NSObject *)value {}
- (void)testByref:(byref NSObject *)value {}
- (void)testOneway:(oneway NSObject *)value {}
@end






@interface YYTestClassInfo : XCTestCase
@end

@implementation YYTestClassInfo

- (void)testClassInfoCache {
    White_YYClassInfo *info1 = [White_YYClassInfo classInfoWithClass:[YYTestPropertyModel class]];
    [info1 setNeedUpdate];
    White_YYClassInfo *info2 = [White_YYClassInfo classInfoWithClassName:@"YYTestPropertyModel"];
    XCTAssertNotNil(info1);
    XCTAssertNotNil(info2);
    XCTAssertEqual(info1, info2);
}

- (void)testClassMeta {
    White_YYClassInfo *classInfo = [White_YYClassInfo classInfoWithClass:[YYTestPropertyModel class]];
    XCTAssertNotNil(classInfo);
    XCTAssertEqual(classInfo.cls, [YYTestPropertyModel class]);
    XCTAssertEqual(classInfo.superCls, [NSObject class]);
    XCTAssertEqual(classInfo.metaCls, objc_getMetaClass("YYTestPropertyModel"));
    XCTAssertEqual(classInfo.isMeta, NO);
    
    Class meta = object_getClass([YYTestPropertyModel class]);
    White_YYClassInfo *metaClassInfo = [White_YYClassInfo classInfoWithClass:meta];
    XCTAssertNotNil(metaClassInfo);
    XCTAssertEqual(metaClassInfo.cls, meta);
    XCTAssertEqual(metaClassInfo.superCls, object_getClass([NSObject class]));
    XCTAssertEqual(metaClassInfo.metaCls, nil);
    XCTAssertEqual(metaClassInfo.isMeta, YES);
}

- (void)testClassInfo {
    White_YYClassInfo *info = [White_YYClassInfo classInfoWithClass:[YYTestPropertyModel class]];
    XCTAssertEqual([self getType:info name:@"boolValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeBool);
#ifdef OBJC_BOOL_IS_BOOL
    XCTAssertEqual([self getType:info name:@"BOOLValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeBool);
#else
    XCTAssertEqual([self getType:info name:@"BOOLValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeInt8);
#endif
    XCTAssertEqual([self getType:info name:@"charValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeInt8);
    XCTAssertEqual([self getType:info name:@"unsignedCharValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeUInt8);
    XCTAssertEqual([self getType:info name:@"shortValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeInt16);
    XCTAssertEqual([self getType:info name:@"unsignedShortValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeUInt16);
    XCTAssertEqual([self getType:info name:@"intValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeInt32);
    XCTAssertEqual([self getType:info name:@"unsignedIntValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeUInt32);
#ifdef __LP64__
    XCTAssertEqual([self getType:info name:@"longValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeInt64);
    XCTAssertEqual([self getType:info name:@"unsignedLongValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeUInt64);
    XCTAssertEqual(YYEncodingGetType("l") & White_YYEncodingTypeMask, White_YYEncodingTypeInt32); // long in 32 bit system
    XCTAssertEqual(YYEncodingGetType("L") & White_YYEncodingTypeMask, White_YYEncodingTypeUInt32); // unsingle long in 32 bit system
#else
    XCTAssertEqual([self getType:info name:@"longValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeInt32);
    XCTAssertEqual([self getType:info name:@"unsignedLongValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeUInt32);
#endif
    XCTAssertEqual([self getType:info name:@"longLongValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeInt64);
    XCTAssertEqual([self getType:info name:@"unsignedLongLongValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeUInt64);
    XCTAssertEqual([self getType:info name:@"floatValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeFloat);
    XCTAssertEqual([self getType:info name:@"doubleValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeDouble);
    XCTAssertEqual([self getType:info name:@"longDoubleValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeLongDouble);
    
    XCTAssertEqual([self getType:info name:@"objectValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeObject);
    XCTAssertEqual([self getType:info name:@"arrayValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeObject);
    XCTAssertEqual([self getType:info name:@"classValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeClass);
    XCTAssertEqual([self getType:info name:@"selectorValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeSEL);
    XCTAssertEqual([self getType:info name:@"blockValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeBlock);
    XCTAssertEqual([self getType:info name:@"pointerValue"] & White_YYEncodingTypeMask, White_YYEncodingTypePointer);
    XCTAssertEqual([self getType:info name:@"functionPointerValue"] & White_YYEncodingTypeMask, White_YYEncodingTypePointer);
    XCTAssertEqual([self getType:info name:@"structValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeStruct);
    XCTAssertEqual([self getType:info name:@"unionValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeUnion);
    XCTAssertEqual([self getType:info name:@"cStringValue"] & White_YYEncodingTypeMask, White_YYEncodingTypeCString);
    
    XCTAssertEqual(YYEncodingGetType(@encode(void)) & White_YYEncodingTypeMask, White_YYEncodingTypeVoid);
    XCTAssertEqual(YYEncodingGetType(@encode(int[10])) & White_YYEncodingTypeMask, White_YYEncodingTypeCArray);
    XCTAssertEqual(YYEncodingGetType("") & White_YYEncodingTypeMask, White_YYEncodingTypeUnknown);
    XCTAssertEqual(YYEncodingGetType(".") & White_YYEncodingTypeMask, White_YYEncodingTypeUnknown);
    XCTAssertEqual(YYEncodingGetType("ri") & White_YYEncodingTypeQualifierMask, White_YYEncodingTypeQualifierConst);
    XCTAssertEqual([self getMethodTypeWithName:@"testIn:"] & White_YYEncodingTypeQualifierMask, White_YYEncodingTypeQualifierIn);
    XCTAssertEqual([self getMethodTypeWithName:@"testOut:"] & White_YYEncodingTypeQualifierMask, White_YYEncodingTypeQualifierOut);
    XCTAssertEqual([self getMethodTypeWithName:@"testInout:"] & White_YYEncodingTypeQualifierMask, White_YYEncodingTypeQualifierInout);
    XCTAssertEqual([self getMethodTypeWithName:@"testBycopy:"] & White_YYEncodingTypeQualifierMask, White_YYEncodingTypeQualifierBycopy);
    XCTAssertEqual([self getMethodTypeWithName:@"testByref:"] & White_YYEncodingTypeQualifierMask, White_YYEncodingTypeQualifierByref);
    XCTAssertEqual([self getMethodTypeWithName:@"testOneway:"] & White_YYEncodingTypeQualifierMask, White_YYEncodingTypeQualifierOneway);
    
    XCTAssert([self getType:info name:@"nonatomicValue"] & White_YYEncodingTypePropertyMask &White_YYEncodingTypePropertyNonatomic);
    XCTAssert([self getType:info name:@"aCopyValue"] & White_YYEncodingTypePropertyMask & White_YYEncodingTypePropertyCopy);
    XCTAssert([self getType:info name:@"strongValue"] & White_YYEncodingTypePropertyMask & White_YYEncodingTypePropertyRetain);
    XCTAssert([self getType:info name:@"retainValue"] & White_YYEncodingTypePropertyMask & White_YYEncodingTypePropertyRetain);
    XCTAssert([self getType:info name:@"weakValue"] & White_YYEncodingTypePropertyMask & White_YYEncodingTypePropertyWeak);
    XCTAssert([self getType:info name:@"readonlyValue"] & White_YYEncodingTypePropertyMask & White_YYEncodingTypePropertyReadonly);
    XCTAssert([self getType:info name:@"dynamicValue"] & White_YYEncodingTypePropertyMask & White_YYEncodingTypePropertyDynamic);
    XCTAssert([self getType:info name:@"getterValue"] & White_YYEncodingTypePropertyMask &White_YYEncodingTypePropertyCustomGetter);
    XCTAssert([self getType:info name:@"setterValue"] & White_YYEncodingTypePropertyMask & White_YYEncodingTypePropertyCustomSetter);
}

- (White_YYEncodingType)getType:(White_YYClassInfo *)info name:(NSString *)name {
    return ((White_YYClassPropertyInfo *)info.propertyInfos[name]).type;
}

- (White_YYEncodingType)getMethodTypeWithName:(NSString *)name {
    YYTestPropertyModel *model = [YYTestPropertyModel new];
    NSMethodSignature *sig = [model methodSignatureForSelector:NSSelectorFromString(name)];
    const char *typeName = [sig getArgumentTypeAtIndex:2];
    return YYEncodingGetType(typeName);
}

@end
