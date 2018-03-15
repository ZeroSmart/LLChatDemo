

#import <Foundation/Foundation.h>

@interface NSString (LLPinyin)

/**
 汉语转拼音 带音标 带空格

 @return 返回带音标的拼音
 */
- (NSString *)ll_pinyinWithPhoneticSymbol;

/**
 汉语转拼音 带空格

 @return 返回不带音标的拼音
 */
- (NSString *)ll_pinyin;

/**
 汉语转拼音

 @return 返回拼音数组
 */
- (NSArray *)ll_pinyinArray;

/**
 汉语转拼音

 @return 返回的拼音各个字之间不带空格分割
 */
- (NSString *)ll_pinyinWithoutBlank;

/**
 提取汉子拼音首字母

 @return 汉子拼音首字母数组
 */
- (NSArray *)ll_pinyinInitialsArray;

/**
 提取汉子拼音首字母

 @return 汉子拼音首字母字符串
 */
- (NSString *)ll_pinyinInitialsString;
@end
