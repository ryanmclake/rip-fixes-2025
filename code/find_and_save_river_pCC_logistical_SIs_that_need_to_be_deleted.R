library(tidyverse)

# LOAD ALL OF THE ORIGINAL PROD DATA


rip_percentCanopyCover_CERT <- restR2::par.get.os.l0.data(dpID = 'DP0.20275.001', 
                                                 startDate = "2015-01-01", 
                                                 endDate = Sys.Date(), 
                                                 ncores = 9, 
                                                 stack = "cert",
                                                 ingestTable = 'rip_percentCanopyCover_in'
)

rip_fieldDataBank_CERT <- restR2::par.get.os.l0.data(dpID = 'DP0.20275.001', 
                                                          startDate = "2015-01-01", 
                                                          endDate = Sys.Date(), 
                                                          ncores = 9, 
                                                          stack = "cert",
                                                          ingestTable = 'rip_fieldDataBank_in'
)

rivers <- c("TOMB|BLWA|FLNT")
locations <- c("01|10|05|06")

rivers_site_1_10_5_6 <- rip_percentCanopyCover_CERT %>%
  filter(grepl(rivers,transectID)) %>%
  filter(grepl(locations,transectID)) %>%
  select(transectID, startDate, dataEntryLatitude, dataEntryLongitude) %>%
  group_by(startDate) %>%
  slice(1)

rivers_site_1_10_5_6_fDB <- rip_fieldDataBank_CERT %>%
  filter(grepl(rivers,transectID)) %>%
  filter(grepl(locations,transectID)) %>%
  select(transectID, startDate, dataEntryLatitude, dataEntryLongitude) %>%
  group_by(startDate) %>%
  slice(1)


FLNT <- rip_percentCanopyCover_CERT %>%
  filter(transectID == "BLWA.AOS.riparian.point.05" | transectID == "BLWA.AOS.riparian.point.06")

BLWA <- rip_percentCanopyCover_CERT %>%
  filter(transectID == "BLWA.AOS.riparian.point.05" | transectID == "BLWA.AOS.riparian.point.06")



BLWA_sampled <- c("BLWA.AOS.riparian.point.06|BLWA.AOS.riparian.point.07|BLWA.AOS.riparian.point.08|BLWA.AOS.riparian.point.09|BLWA.AOS.riparian.point.10")

rip_pCC_rivers_logistical_to_delete <- rip_pCC %>%
  filter(grepl(rivers, transectID)) %>%
  filter(samplingImpractical == "logistical") %>%
  filter(!grepl(BLWA_sampled, transectID)) %>%
  select(uid) %>%
  rename(uuid = uid)

readr::write_delim(rip_pCC_rivers_logistical_to_delete,
                   file=paste0("C:/Users/mcclurer/OneDrive - National Ecological Observatory Network/OS Team - L0dataEditing_2025/rip_fixesOnFixesOnFixes_20250521/editedUpload/rip_percentCanopyCover_rivers_to_delete_uuids_2025.txt"),
                   delim = "\t")



# Note - FLNT 2021 has no pCC data, has all 10 records, but no SI records
# update - fulcrum has all of the records as logistical (RPM spot checked on 05/21/25)

FLNT_fixer <- rip_pCC %>% 
  filter(eventID == "FLNT.2021") %>%
  mutate(samplingImpractical = "logistical")

FLNT_to_delete <- FLNT_fixer %>%
  filter(grepl("01|02|03|05|07",transectID)) %>%
  select(uid) %>%
  rename(uuid = uid)

readr::write_delim(FLNT_to_delete,
                   file=paste0("C:/Users/mcclurer/OneDrive - National Ecological Observatory Network/OS Team - L0dataEditing_2025/rip_fixesOnFixesOnFixes_20250521/editedUpload/rip_percentCanopyCover_FLNT_2021_to_delete_uuids_2025.txt"),
                   delim = "\t")

FLNT_2021_L0_to_update <- FLNT_fixer %>%
  filter(!grepl("01|02|03|05|07",transectID))

readr::write_delim(FLNT_2021_L0_to_update,
                   file=paste0("C:/Users/mcclurer/OneDrive - National Ecological Observatory Network/OS Team - L0dataEditing_2025/rip_fixesOnFixesOnFixes_20250521/editedUpload/rip_percentCanopyCover_update_FLNT_2021_SI_to_logistical.txt"),
                   delim = "\t")
