
######Function to trim white spaces
# returns string w/o leading or trailing whitespace
trim <- function (x) gsub("^\\s+|\\s+$", "", x)




##########
#merge brain size data with metabolic weight data
##########

#data
bmr <- read_excel("~/GoogleDrive/AnimalTraits/birds.xlsx")
bmr$species<-trim(bmr$species)
garnett<-read.csv("~/GoogleDrive/PhD/birdTraits/PublishedData/Australian_Bird_Data_Version_1.csv")
garnett<-garnett[,c("X3_Taxon_common_name_2","Species",
    "X4_Genus_name_2",
    "X10_Family_scientific_name_2",                                                    
    "X192_Breeding_system_Cooperative_12",
    "X190_Nest_aggregation_Colonial_12",
    "X176_Feeding_aggregation_Flocks_11",
    "X112_Brain_volume_8",
    "X113_Brain_mass_8")]

#species
sp<-bmr$species

#subset garnett data for right species
garnett2<-garnett[garnett$Species %in% sp,]
#keep only species level data, not subspecies
garnett2<-subset(garnett2, is.na(X6_Subspecies_name_2))

garnett2<-garnett2[,c("Species",
"X4_Genus_name_2",
"X10_Family_scientific_name_2",                                                    
"X192_Breeding_system_Cooperative_12",
"X190_Nest_aggregation_Colonial_12",
"X176_Feeding_aggregation_Flocks_11",
"X112_Brain_volume_8",
"X113_Brain_mass_8")]

bmr<-merge(bmr,garnett2,by.x= "species", by.y="Species",all.x=TRUE)

write.csv(bmr,"~/GoogleDrive/AnimalTraits/birds2.csv")
