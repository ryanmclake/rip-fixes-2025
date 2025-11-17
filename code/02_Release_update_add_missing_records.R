#### THIS SCRIPT IDENTIFIES SITE.YEARS MISSING THAT WILL HAVE AN SI RECORD MADE FOR THEM



rip_percentCanopyCover_CERT <- restR2::par.get.os.l0.data(dpID = 'DP0.20275.001', 
                                                          startDate = "2015-01-01", 
                                                          endDate = Sys.Date(), 
                                                          ncores = 9, 
                                                          stack = "prod",
                                                          ingestTable = 'rip_percentCanopyCover_in'
)


# RPM REVIEWED THE PORTAL TO EASILY VET WHAT SITES ARE MOSSINF FOR WHAT YEAR. HOWEVER, BELOW IS A 
# QUiCK SCRIPT THAT DOES RAW COUNT FOR THE NUMBER OF SITES THAT HAVE RECORDS FOR EACH YEAR
# FOR CONTEXT, THE PERCENT CANOPY COVER DATA SHOULD HAVE 27 RECORDS PER YEAR STARTING IN 2020

missing_sites_years <- rip_percentCanopyCover_CERT |>
  select(eventID) |>
  reframe(eventIDs_in_L0 = unique(eventID))|>
  tidyr::separate(eventIDs_in_L0, into = c("siteID","year"))|>
  group_by(year)|>
  summarise(num_records = n_distinct(siteID))

names(rip_percentCanopyCover_CERT)

# Here are all the missing records between 2018 and end of 2024
tomake <- c("BLWA.2018",
          "TOMB.2018",
          "OKSR.2018",
          "TECR.2018",
          "FLNT.2018",
          "BLWA.2019",
          "TOMB.2019",
          "FLNT.2019",
          "ARIK.2020",
          "WLOU.2020",
          "FLNT.2020",
          "LECO.2020",
          "WALK.2020",
          "REDB.2020",
          "MART.2020",
          "FLNT.2021",
          "ARIK.2022",
          "COMO.2022",
          "WLOU.2022",
          "KING.2022",
          "MCDI.2022",
          "CUPE.2022",
          "BLDE.2022",
          'CUPE.2024')


#creating the data matrix
matrix=matrix(NA, nrow=24,ncol=length(unique(names(rip_percentCanopyCover_CERT))))

# make it a data frame
records_to_upload <- as.data.frame(matrix)

# update the names of the columns to match what is in rip_percentCanopyCover_CERT
names(records_to_upload) <- c(names(rip_percentCanopyCover_CERT))

pCC_records_to_upload <- records_to_upload |>
  mutate(eventID = tomake)
  








rip_fieldDataBank_CERT <- restR2::par.get.os.l0.data(dpID = 'DP0.20275.001', 
                                                     startDate = "2015-01-01", 
                                                     endDate = Sys.Date(), 
                                                     ncores = 9, 
                                                     stack = "cert",
                                                     ingestTable = 'rip_fieldDataBank_in'
)


# RPM REVIEWED THE PORTAL TO EASILY VET WHAT SITES ARE MOSSINF FOR WHAT YEAR. HOWEVER, BELOW IS A 
# QUiCK SCRIPT THAT DOES RAW COUNT FOR THE NUMBER OF SITES THAT HAVE RECORDS FOR EACH YEAR
# FOR CONTEXT, THE RIPARIAN COMPOSTITION DATA SHOULD HAVE 27 RECORDS PER YEAR STARTING IN 2020

missing_sites_years <- rip_fieldDataBank_CERT |>
  select(eventID) |>
  reframe(eventIDs_in_L0 = unique(eventID))|>
  tidyr::separate(eventIDs_in_L0, into = c("siteID","year"))|>
  group_by(year)|>
  summarise(num_records = n_distinct(siteID))


# Here are all the missing records between 2018 and end of 2024
# TECR.2018
# ARIK.2020
# WLOU.2020
# BARC.2020
# SUGG.2020
# FLNT.2020
# LECO.2020
# WALK.2020
# REDB.2020
# MART.2020
# ARIK.2022
# COMO.2022
# WLOU.2022
# KING.2022
# MCDI.2022
# CUPE.2022 --> might be in 2023
# BLDE.2022
# CUPE.2024



