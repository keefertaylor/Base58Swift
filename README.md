# Base58Swift 

[![Build Status](https://travis-ci.org/keefertaylor/Base58Swift.svg?branch=master)](https://travis-ci.org/keefertaylor/Base58Swift)
[![codecov](https://codecov.io/gh/keefertaylor/Base58Swift/branch/master/graph/badge.svg)](https://codecov.io/gh/keefertaylor/Base58Swift)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/Base58Swift.svg?style=flat)](http://cocoapods.org/pods/Base58Swift)
[![License](https://img.shields.io/cocoapods/l/Base58Swift.svg?style=flat)](http://cocoapods.org/pods/Base58Swift)

Base58Swift is a Swift library that implements Base58 encodings for crypto currencies. It is based off of [go-base-58](https://github.com/jbenet/go-base58).

Donations help me find time to work on Base58Swift. If you find the library useful, please consider donating to support ongoing develoment.

|Currency| Address |
|---------|---|
| __Tezos__ | tz1SNXT8yZCwTss2YcoFi3qbXvTZiCojx833 |
| __Bitcoin__ | 1CdPoF9cvw3YEiuRCHxdsGpvb5tSUYBBo |
| __Bitcoin Cash__ | qqpr9are9gzs5r0q7hy3gdehj3w074pyqsrhpdmxg6 |


## Installation

### CocoaPods
Base58Swift supports installation via CocoaPods. You can depened on Base58Swift by adding the following to your Podfile:

```
pod "Base58Swift"
```

### Carthage

If you use [Carthage](https://github.com/Carthage/Carthage) to manage your dependencies, simply add
Base58Swift to your `Cartfile`:

 ```
github "keefertaylor/Base58Swift"
```

 If you use Carthage to build your dependencies, make sure you have added `BigInt.framework` and `SipHash.framework`, to the "_Linked Frameworks and Libraries_" section of your target, and have included them in your Carthage framework copying build phase.

## Usage

TODO: Write this section.

## Contributing

I am happy to accept pull requests. 

## License

MIT
