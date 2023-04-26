
library(lidR) 
library(RCSF) 

#Create list of all of the las files files to be processed within a folder

#input location for container
lidar2020 = list.files("/data",pattern="*.copc.laz$", full.names=TRUE )

#input location using VICE rstudio
#lidar2020 = list.files("/data-store/iplant/home/jgillan/STAC_drone",pattern="*.copc.laz$", full.names=TRUE )

#Set up loop to process each las file to create canopy height model raster
for(fileName in lidar2020) {
  
  lidar_points = readLAS(fileName)
  
  #Identify ground points using a cloth simulation filter algorithm
  points_classified = classify_ground(lidar_points, algorithm = csf(sloop_smooth = FALSE, class_threshold = 0.4, cloth_resolution =  0.25, rigidness = 2))
  
  #Output location when using VICE rstudio
  #output_las_file <- "/data-store/iplant/home/jgillan/STAC_drone/test_cloud.laz"
  
  #Output location when using container
  output_las_file <- "${file%.laz}.laz"
  
  writeLAS(points_classified, output_las_file)
}