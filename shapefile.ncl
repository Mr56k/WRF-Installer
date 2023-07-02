begin
  filename = "wrfout_d01_2023-06-29.nc"
  a        = addfile(filename,"r")

  tc  = wrf_user_getvar(a,"tc",0)            ; temperature (degC)

 wtype          = "png"
 ;wtype@wkWidth  = 1920     ; Set the pixel size of PNG image.
 ;wtype@wkHeight = 1080

  wks = gsn_open_wks(wtype,"Bodentemperatur")     ; send graphics to PNG file

  res                   = True               ; Contour options
  res@cnFillOn          = True               ; Create a color fill plot
  res@Footer            = False
  res@MainTitle         = "Temperatur (C)"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Which times and how many time steps are in the data set?
  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  ntimes = dimsizes(times)         ; number of times in the file


  it = ntimes-1                    ; only interested in last time
  res@TimeLabel = times(it)        ; set Valid time to use on plot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  contour = wrf_contour(a,wks,tc(0,:,:),res)       ; Create contour plot

  pltres            = True   ; Basic overlay plot options
  pltres@PanelPlot  = True   ; Tells wrf_map_overlays not to remove overlays

  mpres             = True   ; Set map options
  mpres@mpOutlineOn = False  ; Turn off map outlines
  mpres@mpFillOn    = False  ; Turn off map fill

;---Create the contours over the WRF map (nothing will be drawn yet).
  plot = wrf_map_overlays(a,wks,contour,pltres,mpres) 

;---Attach the shapefile polylines using files read off gadm.org/country.
  ger_shp_name    = "gadm41_DEU_1.shp"
  
  lnres                  = True
  lnres@gsLineColor      = "gray5"
  lnres@gsLineThicknessF = 2.0   

  ger_id = gsn_add_shapefile_polylines(wks,plot,ger_shp_name,lnres)
  
  draw(plot)       ; This will draw the map and the shapefile outlines.
  frame(wks)       ; Advance the frame

  delete(wks)

  cmd = "composite -geometry 135x90+0+0 logo.png Bodentemperatur.png Bodentemperatur.png"
  system(cmd)

  cmd = "magick Bodentemperatur.png Bodentemperatur.png"
  system(cmd)
end
