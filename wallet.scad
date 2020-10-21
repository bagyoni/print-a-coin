usage = "usage: openscad -D \"privateKey=\\\"$PRIVATE_KEY\\\"; obverseImage=\\\"$IMAGE_FILENAME\\\";\" -o wallet.stl wallet.scad";

assert(privateKey, usage);
assert(obverseImage, usage);
assert(len(privateKey) <= 66, "Private key is too long!");

font = "Courier Prime Code";
fontSize = 3;
lineSpacing = 3.5;
charactersPerLine = 11;
coinDiameter = 40;
coinNetThickness = 6;
coinRim = 2;
pocketDepth = 2.5;
textOffset = [13.5, 7, pocketDepth];
textDepth = 0.7;
sealThickness = 1;
obverseThickness = 3;
epsilon = 0.1;

function _str_concat(strings, count) =
	count == 0 ? "" :
	str (strings[0], _str_concat([for (i = [1 : count]) strings[i]], count - 1));

function str_concat(strings) = _str_concat(strings, len(strings));

function substring(string, start, end) =
	str_concat([for (j = [ start : end - 1 ])
		j >= len(string) ? "" : string[j]]);

function wrap(string, lineLength) = [
	for (i = [0 : len(string) / lineLength])
		substring(string, i * lineLength, (i + 1) * lineLength)
];

module pocket() {
	translate([0, 0, -epsilon])
	cylinder(d = coinDiameter - coinRim * 2, h = pocketDepth);
}

module inscription() {
	privateKeyLines = wrap(privateKey, charactersPerLine);
	translate(textOffset)
	for (i = [0 : len(privateKeyLines)]) {
		linear_extrude(textDepth * 2, center = true)
		translate([0, -i * lineSpacing])
		mirror([1, 0])
		text(privateKeyLines[i], fontSize, font);
	}
}

module perforation() {
	holes = 10;
	holeDepth = coinRim - 0.4;
	holeCurvature = 7;
	translate([0, 0, sealThickness])
	for (i = [1 : holes - 1]) {
		rotate([0, 0, i * 360 / holes - 90])
		translate([coinDiameter / 2 + holeCurvature - holeDepth, 0, 0])
		cylinder(r = holeCurvature, h = pocketDepth - sealThickness);
	}
}

module coin_body() {
	difference() {
		cylinder(d = coinDiameter, h = coinNetThickness);
		pocket();
		inscription();
		perforation();
	}
}

module coin_obverse() {
	translate([0, 0, coinNetThickness])
	intersection() {
		resize([coinDiameter, coinDiameter, obverseThickness])
		surface(obverseImage, center = true);
		cylinder(d = coinDiameter - 2, h = obverseThickness + epsilon);
	}
}

module coin_reverse() {
	cylinder(d=coinDiameter, h=sealThickness);
}

module support() {
	supportWidth = 30;
	linear_extrude(0.7)
	translate([-supportWidth / 2, -coinNetThickness, 0])
	square([supportWidth, coinNetThickness]);
}

translate([0, 0, coinDiameter / 2])
rotate([90, 0, 0]) {
	coin_body();
	coin_reverse();
	coin_obverse();
}
support();
