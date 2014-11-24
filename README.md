# HZRButton

[![Version](https://img.shields.io/cocoapods/v/HZRButton.svg?style=flat)](http://cocoadocs.org/docsets/HZRButton)
[![License](https://img.shields.io/cocoapods/l/HZRButton.svg?style=flat)](http://cocoadocs.org/docsets/HZRButton)
[![Platform](https://img.shields.io/cocoapods/p/HZRButton.svg?style=flat)](http://cocoadocs.org/docsets/HZRButton)

## Demo 

![HZRButton demo](https://raw.githubusercontent.com/erdincakkaya/HZRButton/master/hzrbutton_demoss.gif)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Add HZRButtonDelegate to get callback when animation finished,

`- (void)animatingButtonDidFinishLoading:(HZRButton *)button`

Create button, customize as you want.

``` objective-c
HZRButton *button = [[HZRButton alloc]init];
....
....
[button addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];

- (void)save:(HZRButton *)sender{
    [file saveInBackgroundWithBlock:^(BOOL succeed, NSError *error) {
        NSLog(@"upload succeeded");
    } progressBlock:^(int percentDone) {
        [sender updatePercentage:percentDone]; // keep updating the percentage.
    }];
}

// this is called when the loading animation finished. 
- (void)animatingButtonDidFinishLoading:(HZRButton *)button{
    NSLog(@"loading finished %@", button);
}

```

## Installation

HZRButton is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

pod "HZRButton"

## Author

Erdinc Akkaya, hz.root@gmail.com

## License

HZRButton is available under the MIT license. See the LICENSE file for more info.