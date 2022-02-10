#!/bin/bash

for i in $(for y in $(find . | gawk '/what/ && /else/ && /you/ && /need/ && !/or_not/'); do p=$(grep something "$y"); if [[ -z "$p" ]]; then echo "$y"; fi; done)
do
  if [[ -n $(gawk 'FNR>7 {nextfile} /labels/{print NR}' "$i") ]];
  then
    x=$(gawk '/labels/{print NR+1; nextfile}' "$i");
    gawk -i inplace -v line="$x" 'NR==line{print "      severity: undefined"}1' "$i";
  else
    x=$(gawk '/spec/{print NR; nextfile}' "$i");
    gawk -i inplace -v line="$x" 'NR==line{print "    labels:\n      severity: undefined"}1' "$i";
  fi;
done
