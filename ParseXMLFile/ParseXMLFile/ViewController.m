//
//  ViewController.m
//  ParseXMLFile
//
//  Created by 朝阳 on 2017/12/7.
//  Copyright © 2017年 sunny. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSXMLParserDelegate>

/* 保存xml中的子节点 */
@property (nonatomic, strong) NSMutableArray *viewArray;
/* 用来记录当前xml解析的节点名称 */
@property (nonatomic, copy) NSString *currentElementName;

@end

@implementation ViewController


- (IBAction)SAXParse:(UIButton *)sender {
    
    //1. 加载xml文件
    NSString *xmlFilePath = [[NSBundle mainBundle] pathForResource:@"Demo.xml" ofType:nil];
    //2. 把xml文件中的内容解析成 二进制数据
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlFilePath];
    //3. 使用NSXMLParser
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    // 设置代理
    xmlParser.delegate = self;
    // 开始解析
    [xmlParser parse];
    
}

#pragma -mark NSXMLParserDelegate代理方法
// 开始
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"开始");
    // 创建数组
    self.viewArray = [NSMutableArray array];
}

// 获取节点头(及节点属性等)
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    // 获取节点头
    NSLog(@"节点头 : %@",elementName);
    self.currentElementName = elementName;
    if ([elementName isEqualToString:@"button"]) {
        UIButton *btn = [[UIButton alloc] init];
        [_viewArray addObject:btn];
        
        [btn setTitle:attributeDict[@"name"] forState:UIControlStateNormal];
        
        NSInteger x = [attributeDict[@"x"] integerValue];
        NSInteger y = [attributeDict[@"y"] integerValue];
        NSInteger w = [attributeDict[@"w"] integerValue];
        NSInteger h = [attributeDict[@"h"] integerValue];
        btn.frame = CGRectMake(x, y, w, h);
        
        btn.backgroundColor = [UIColor grayColor];
        
        [self.view addSubview:btn];
        
    }else if ([elementName isEqualToString:@"textField"]){
        
        UITextField *textFiled = [[UITextField alloc] init];
        
        NSInteger x = [attributeDict[@"x"] integerValue];
        NSInteger y = [attributeDict[@"y"] integerValue];
        NSInteger w = [attributeDict[@"w"] integerValue];
        NSInteger h = [attributeDict[@"h"] integerValue];
        
        textFiled.frame = CGRectMake(x, y, w, h);
        
        textFiled.backgroundColor = [UIColor clearColor];
        textFiled.placeholder = attributeDict[@"placeholder"];
        textFiled.borderStyle = [attributeDict[@"borderStyle"] integerValue];
        
        
        [_viewArray addObject:textFiled];
        
        [self.view addSubview:textFiled];
        
    }else{
        
        NSInteger x = [attributeDict[@"x"] integerValue];
        NSInteger y = [attributeDict[@"y"] integerValue];
        NSInteger w = [attributeDict[@"w"] integerValue];
        NSInteger h = [attributeDict[@"h"] integerValue];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        imageView.image = [UIImage imageNamed:@"head.jpg"];
        [_viewArray addObject:imageView];
        [self.view addSubview:imageView];
        
        
    }
    
}

// 获取节点的值(这个方法会在节点头 和 节点尾分别调用一次)
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
}

// 获取节点尾
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"节点尾 : %@", elementName);
}

// 结束
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"结束");
    NSLog(@"%@",_viewArray);
}

@end



