#  Cat: a desktop pet for your Mac

A desktop pet for your Mac, that follows your mouse or trackpad pointer around the screen.

Inspired by the venerable Neko program and its many variants, Cat offers its own modern
take, supporting crisp retina graphics on modern Mac systems.

## Building

Clone this repository using your favorite graphical tool or the command line.

```sh
git clone https://github.com/mmar/Cat.git
```

Create a `Developer.xcconfig` file with a unique bundle identifier and, optionally, your
Development Team ID. You can copy and edit the included template, just make sure not to
include it in the Xcode project, as it will not be commited to Git. Or use the shell:

```sh
cd Cat
echo "PRODUCT_BUNDLE_IDENTIFIER = <Reverse-DNS Identifier>" > Developer.xcconfig
echo "DEVELOPMENT_TEAM = <Your Team ID>" >> Developer.xcconfig
```

Use Xcode to normally build and run on your Mac.
