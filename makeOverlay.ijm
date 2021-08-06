//load images
run("Image Sequence...", "open=[C:/Users/luisf/Desktop/HW ALL/HW All M/] sort");

//threshold and analyze particles to get overlays
setAutoThreshold("Default dark");
setOption("BlackBackground", true);
run("Convert to Mask", "method=Default background=Light calculate black");
run("Analyze Particles...", "size=0-infinity circularity=0-1 show=Overlay display include stack");//change size to set particle size range; change circularity to set particle roundness
run("To ROI Manager");

//generate blank images
run("Analyze Particles...", "  show=[Bare Outlines] display include stack");

//select new window
imageTitle=getTitle();//returns a string with the image title
selectWindow(imageTitle);

//erase images
run("Colors...", "foreground=black background=white");//choose either white lines on black background or black lines on white
run("Select All");
run("Clear");

//load in overlays
run("From ROI Manager");

//display overlay (with thicker lines)
run("Overlay Options...", "stroke=black width=12 fill=none set apply");//change stroke to set line color -- make sure is different from background color
run("Overlay Options...", "stroke=black width=30 fill=none set apply");
run("Overlay Options...", "stroke=black width=12 fill=none set apply");
run("Flatten", "stack");
run("8-bit");

//bring in calibration bar and concatenate stacks
run("Image Sequence...", "open=[C:/Users/luisf/Desktop/HW ALL/Calibration bar/] sort");
run("Concatenate...", "open image1=[Drawing of HW All M] image2=[Calibration bar] image3=[-- None --]");

//make z projection
run("Z Project...", "projection=[Sum Slices]");

//generate heatmap/lookup table
run("16 colors");
setMinAndMax("38151.39", "52680.41");//adjust brightness and contrast