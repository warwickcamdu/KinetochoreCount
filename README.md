# KinetochoreCount
Find and count kinetochores in embryo images

## Setup
- Download Fiji
- Install 3D ImageJ Suite plugin. [Instructions](https://mcib3d.frama.io/3d-suite-imagej/)
### Optional
To read Slidebook files
- Install Slidebook Reader plugin. [Instructions](https://www.intelligent-imaging.com/technical-answers)

## Use
1. Open macro in Fiji
2. Click run
3. Enter or browse to the path of the files to analyse. Expected input is series of 3D image stacks with multiple channels.
4. Enter or browse to a folder to save the results (Use an empty folder to prevent overwriting existing files
5. Enter the channel number which should be used to identify the kinetochores
6. Click OK

## Output
Three files per image stack will be saved. First is an .roi file which identifies an enlarged bounding box around the kinetochores. Second is a tif image stack of the cropped region around the kinetochores. Third is a .zip folder containing the ROI set of points identifying the kinetochores in the cropped image stack. The log file will list the image stacks and number of kinetochores interspersed with output from the 3D Maxima Finder.

## References
J. Ollion, J. Cochennec, F. Loll, C. Escudé, T. Boudier. (2013) TANGO: A Generic Tool for High-throughput 3D Image Analysis for Studying Nuclear Organization. Bioinformatics 2013 Jul 15;29(14):1840-1. [doi](http://dx.doi.org/10.1093/bioinformatics/btt276)
