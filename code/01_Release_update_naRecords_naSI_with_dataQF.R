library(tidyverse)


# There are instances where the transectID and associated records have NAs in the records and do not have enough records
# for that transect (which should be 6). 

# Ryan talked with some field scientists who have been here when these records were made and they said it was 
# most likely due to a dry stream bed. However, that cannot truly be determined for all records with this violation
# because there are no remarks highlighting that the stream bed was dry at that transect. 

# Ryan has written a whole new KBA to alleviate this issue at least for dry streams, which, has been a 
# discussion point among him and FSCI. (KBA: KB0013682) This update was also approved by the IPT. 

# The question remains what to do with these transect ID records that have NA in the data and the SI. 
# They may be due to a dry stream bed, but they may not. Thus, we will never truly know 
# I err on the side to make these have a dataQF that just says that Canopy cover was not recorded at this transect
# or something along those lines. 

rip_percentCanopyCover_CERT <- restR2::par.get.os.l0.data(dpID = 'DP0.20275.001', 
                                                          startDate = "2015-01-01", 
                                                          endDate = Sys.Date(), 
                                                          ncores = 9, 
                                                          stack = "cert",
                                                          ingestTable = 'rip_percentCanopyCover_in'
)

# find the instances where the SI is NA but the canopy cover is also NA, meaning it is not SI but they don't
# have data with that point. 

flags_update_with_QF <- rip_percentCanopyCover_CERT |>
  filter(is.na(samplingImpractical) & is.na(totalDensiometerPoints)) |>
  mutate(dataQF = "Canopy cover not recorded at this riparian transect")


### WRITE THE edit RECORDS TABLE TO FOLDER L0Editing TO UPLOAD TO PROD
readr::write_delim(flags_update_with_QF,
                   file=paste0("C:/Users/mcclurer/OneDrive - National Ecological Observatory Network/OS Team - L0dataEditing_2025/rip_naRecord_naSI_updates_20251117/01_add_dataQF_toNA_records_percentCanopyCover_CERT.txt"),
                   delim = "\t")


##### DO IT ALL IN PROD #####

# There are instances where the transectID and associated records have NAs in the records and do not have enough records
# for that transect (which should be 6). 

# Ryan talked with some field scientists who have been here when these records were made and they said it was 
# most likely due to a dry stream bed. However, that cannot truly be determined for all records with this violation
# because there are no remarks highlighting that the stream bed was dry at that transect. 

# Ryan has written a whole new KBA to alleviate this issue at least for dry streams, which, has been a 
# discussion point among him and FSCI. (KBA: KB0013682) This update was also approved by the IPT. 

# The question remains what to do with these transect ID records that have NA in the data and the SI. 
# They may be due to a dry stream bed, but they may not. Thus, we will never truly know 
# I err on the side to make these have a dataQF that just says that Canopy cover was not recorded at this transect
# or something along those lines. 

rip_percentCanopyCover_PROD <- restR2::par.get.os.l0.data(dpID = 'DP0.20275.001', 
                                                          startDate = "2015-01-01", 
                                                          endDate = Sys.Date(), 
                                                          ncores = 9, 
                                                          stack = "prod",
                                                          ingestTable = 'rip_percentCanopyCover_in'
)

# find the instances where the SI is NA but the canopy cover is also NA, meaning it is not SI but they don't
# have data with that point. 

flags_update_with_QF <- rip_percentCanopyCover_CERT |>
  filter(is.na(samplingImpractical) & is.na(totalDensiometerPoints)) |>
  mutate(dataQF = "Canopy cover not recorded at this riparian transect")


### WRITE THE edit RECORDS TABLE TO FOLDER L0Editing TO UPLOAD TO PROD
readr::write_delim(flags_update_with_QF,
                   file=paste0("C:/Users/mcclurer/OneDrive - National Ecological Observatory Network/OS Team - L0dataEditing_2025/rip_naRecord_naSI_updates_20251117/01_add_dataQF_toNA_records_percentCanopyCover_PROD.txt"),
                   delim = "\t")
