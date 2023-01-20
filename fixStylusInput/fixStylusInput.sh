#!/bin/bash
debug=false

xinput list | nl
echo "Which line number has the correct input (Should have something like the string 'slave pointer (2)' and 'Stylus Pen' in it)"
read xinput_line

selected_xinput=$(xinput list | sed -n "${xinput_line} p" | awk -F '↳ ' '{print $2}' | awk -F 'id=' '{print $1}' | xargs)

xinput_props=$(xinput list-props "${selected_xinput}")

if [[ "$xinput_props" != *"Coordinate Transformation Matrix"* ]]; then
  echo "Could not find required Coordinate Transformation Matrix property in selected device"
  exit 1
fi

if [[ debug == "true" ]]; then echo $xinput_props; fi


resolutions=$(xrandr --query | grep -w 'connected' | cut -d ' ' -f3-4 | cut -d '+' -f1 | cut -d ' ' -f2)
offsets=$(xrandr --query | grep -w 'connected' | cut -d ' ' -f3-4 | cut -d '+' -f2-3 | cut -d ' ' -f1)
#total_area_width=(echo $offsets | cut -d '+' -f1)
widths=$(printf '%s\n' $resolutions | cut -d 'x' -f1)
heights=$(printf '%s\n' $resolutions | cut -d 'x' -f2)


printf '%s\n' $resolutions | nl
echo "Which screen is your touch screen?"
read screen

touch_area_height=$(printf '%s\n' $heights | sed -n "${screen} p")
touch_area_width=$(printf '%s\n' $widths | sed -n "${screen} p")

#horizontal
total_height=$touch_area_height

total_width=0

touch_area_width_offset=$(printf '%s\n' $offsets | sed -n "${screen} p" | cut -d '+' -f1)
touch_area_height_offset=$(printf '%s\n' $offsets | sed -n "${screen} p" | cut -d '+' -f2)

for ((i = 1; i <= $(printf '%s\n' $resolutions | wc -l); i++)); do
  current_screen_width=$(printf '%s\n' $widths | sed -n "${i} p")
  if [[ debug == "true" ]]; then echo "screen_width=$current_screen_width"; fi
  current_screen_height=$(printf '%s\n' $heights | sed -n "${i} p")
  if [[ debug == "true" ]]; then echo "screen_height=$current_screen_height"; fi
  if [[ debug == "true" ]]; then echo "echo $total_width+$current_screen_width | bc"; fi
  total_width=$(echo "$total_width+$current_screen_width" | bc)
  if [[ debug == "true" ]]; then echo "total_width=$total_width"; fi

  if [[ debug == "true" ]]; then echo "if $touch_area_height -lt $current_screen_height"; fi
  if [[ "$touch_area_height" -lt "$current_screen_height" ]]; then
    total_height=$current_screen_height
  fi
  if [[ debug == "true" ]]; then echo "total_height=$total_height"; fi

done

if [[ debug == "true" ]]; then echo "$touch_area_width/$total_width"; fi

touch_width_ratio_c0=$(echo "$touch_area_width/$total_width" | bc -l)
if [[ debug == "true" ]]; then echo "touch_width_ratio_c0=$touch_width_ratio_c0"; fi

touch_width_offset_ratio_c1=$(echo "$touch_area_width_offset/$total_width" | bc -l)
if [[ debug == "true" ]]; then echo "touch_width_offset_ratio_c0=$touch_width_offset_ratio_c0"; fi

touch_height_ratio_c2=$(echo "$touch_area_height/$total_height" | bc -l)
if [[ debug == "true" ]]; then echo "touch_height_ratio_c0=$touch_height_ratio_c0"; fi

touch_height_offset_ratio_c3=$(echo "$touch_area_height_offset/$total_height" | bc -l)
if [[ debug == "true" ]]; then echo "touch_height_offset_ratio_c0=$touch_height_offset_ratio_c0"; fi

if [[ debug == "true" ]]; then echo $touch_width_ratio_c0 0 $touch_width_offset_ratio_c1 0 $touch_height_ratio_c2 $touch_height_offset_ratio_c3 0 0 1; fi

echo "Run: 'xinput set-prop "${selected_xinput}" --type=float "Coordinate Transformation Matrix" $touch_width_ratio_c0 0 $touch_width_offset_ratio_c1 0 $touch_height_ratio_c2 $touch_height_offset_ratio_c3 0 0 1' (y/N)?"
read run


case $run in 
  [yY] ) echo "Running command";
    xinput set-prop "${selected_xinput}" --type=float "Coordinate Transformation Matrix" $touch_width_ratio_c0 0 $touch_width_offset_ratio_c1 0 $touch_height_ratio_c2 $touch_height_offset_ratio_c3 0 0 1;;
  [nN] ) echo "exiting...";
    exit;;
  * ) echo "exiting";
    exit;;
	
esac

echo "ALL SET! :)"
