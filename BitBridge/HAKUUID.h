//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//



@class NSUUID;

@interface HAKUUID : NSObject <NSCopying, NSCoding>
{
    unsigned long long _type;
    NSUUID *_uuid;
}

+ (BOOL)isValidUUIDString:(id)arg1;
+ (id)nameMapping;
@property(retain, nonatomic, setter=setUUID:) NSUUID *uuid; // @synthesize uuid=_uuid;
@property(nonatomic) unsigned long long type; // @synthesize type=_type;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithCoder:(id)arg1;
- (id)copyWithZone:(struct _NSZone *)arg1;
- (id)name;
- (id)UUIDString;
- (id)debugDescription;
- (id)description;
- (BOOL)isEqualTo:(id)arg1;
- (unsigned long long)hash;
- (id)initWithUUID:(id)arg1;
- (id)initWithUUIDString:(id)arg1;
- (id)init;
- (id)shortenedUUIDString;

@end
