## What is this?

An OpenSCAD program that generates a 3D printable cryptocurrency wallet that looks like an actual coin. It's the unholy combination of Bitcoin paper wallets and those stock photos you see in news articles.


## How can I make one?

First and foremost: AT YOUR OWN RISK. This software comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. Do not count on this wallet to offer any form of protection for your digital assets.

If you understand the above and wish to proceed...

In order to use this project, the following dependencies need to be installed:
- OpenSCAD version 2019.01-RC2 or later (https://github.com/openscad/openscad)
- the Courier Prime Code font (https://github.com/quoteunquoteapps/CourierPrimeCode)

If you're using Windows, you will need to copy the font file to a directory named .fonts in your user directory, otherwise OpenSCAD won't find it.

You could use any other monospaced font of your choice, but then you'll have to adjust the coinDiameter, fontSize, lineSpacing, charactersPerLine, textOffset and possibly textDepth variables in the code manually.

You can create a new physical wallet via the following command:

```
openscad -D "privateKey=\"$PRIVATE_KEY\"; obverseImage=\"$IMAGE_FILENAME\";" -o wallet.stl wallet.scad
```

Here, $PRIVATE_KEY stands for the private key of the wallet in your preferred format. The 3D wallet can store a maximum of 66 characters, which should be more than enough for both WIF and BIP 38 strings.

$IMAGE_FILENAME should be a (relative or absolute) path pointing to the icon of the digital asset held in the wallet. This will be the "obverse" of the "coin". Some examples are provided in this repo, but you can use any logo as long as it is a PNG file of a reasonably small resolution (anything above 256x256 is a waste of CPU power). The logo you provided will be converted into a height map by the magic of OpenSCAD to adorn the front side of your wallet.

Next, slice wallet.stl and print it. My own setup is: PLA, 20% infill, 0.1mm layer height, 0.4mm nozzle, brim. After it is printed, carefully remove the support structure and **sign the reverse of the coin** with a permanent marker. I recommend that you print two copies with the exact same configuration so you can open up one of them, check that the private key is legible, then safely destroy it.


## Okay, I made one, how do I spend it?

Carefully push a small blade into one of the holes around the rim. If it doesn't give way, wiggle it a bit or try another hole; don't push too hard. Then carefully turn the blade to separate the reverse from the rest of the coin. Repeat with multiple holes if necessary.

Another approach that worked well for me is to grind away the rim on all sides and pull off the reverse. PLA is very easy to grind, a rough concrete or stone surface will do the trick. Be very careful not to remove more than the outer 2-3mm of the coin; stop grinding as soon as you see the narrow gap under the reverse. This procedure takes longer (about 10 minutes), but you're less likely to harm yourself or the private key.

After you got the reverse off, you should see the private key engraved underneath.


## Couldn't you get the private key out using X-ray or some other imaging technique?

Quite sure you can. And that's just one of the many reasons not to put too much trust in this thing.


## Why don't you store the private key as a QR code?

I wanted to do that, but:
- While I managed to get a QR scanner to read a 3D printed QR code, it required a lot of post-processing in GIMP. This defeats the purpose of QR codes.
- You normally scan QR codes using a smartphone app, and who knows where that app - and your phone - is sending your data.
- This project is 100% OpenSCAD, and I want to keep it this way for security reasons. Haven't found a reliable OpenSCAD library for generating QR codes.


## Acknowledgements

Images used in this project:
- AUSbitcoins Logo by Satoshi
- Official Litecoin logo by the Litecoin Community
- Ethereum logo by the Ethereum Foundation
