# Extract Australia from a set of geotiffs.

# Assumes data are in geographic coordinate system, all in one folder.

#  outputs are in a subfolder, specified by the outdir variable

library(terra)  #  faster than raster
# library (raster)
library (sf)

# update as needed
outdir = "australia"
precision_multiplier = 10


if (!dir.exists (outdir)) {
  dir.create(outdir)
}

#  set extent to australia
#  could extract from rnaturalearth
#  minx, maxx, miny, maxy
ext = c(113.3390, 153.56947, -43.6346, -10.66819)

#  all files ending in .tif
files = list.files(pattern = '.tif$')

for (f in files) {
  message (f)
  r = raster(f)
  new = floor (precision_multiplier * crop(r, ext)) / precision_multiplier
  newname = paste(outdir, f, sep="/")
  writeRaster(new, newname)  #  same name, just new directory
}

