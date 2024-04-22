#!/bin/bash

image_dir="../libexec/"
image_name="ascii.sif"

cmd="$(basename $0)"

args="$@"

apptainer exec $image_dir/$image_name $cmd $args
