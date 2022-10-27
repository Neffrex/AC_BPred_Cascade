#/usr/bin/bash

call_dir=$(pwd)
root_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/..

configs=('intel2' 'amd2')

for curr_config in ${configs[@]}; do
    
    # ammp
    cd ${root_dir}/specs/ammp/data/ref
    ${root_dir}/sim-outorder -config ${root_dir}/config/${curr_config}.txt ${root_dir}/specs/ammp/exe/ammp.exe <${root_dir}/specs/ammp/data/ref/ammp.in 2>${root_dir}/stats/${curr_config}_ammp &
    
    # eon
    cd ${root_dir}/specs/eon/data/ref
    ${root_dir}/sim-outorder -config ${root_dir}/config/${curr_config}.txt ${root_dir}/specs/eon/exe/eon.exe chair.control.cook chair.camera chair.surfaces chair.cook.ppm ppm pixels_out.cook 2>${root_dir}/stats/${curr_config}_eon &
    
    #equake
    cd ${root_dir}/specs/equake/equake/data/ref
    ${root_dir}/sim-outorder -config ${root_dir}/config/${curr_config}.txt ${root_dir}/specs/equake/equake/exe/equake.exe <${root_dir}/specs/equake/equake/data/ref/inp.in 2>${root_dir}/stats/${curr_config}_equake &

    #gap
    cd ${root_dir}/specs/gap/gap/data/ref
    ${root_dir}/sim-outorder -config ${root_dir}/config/${curr_config}.txt ${root_dir}/specs/gap/gap/exe/gap.exe -l ${root_dir}/specs/gap/gap/data/all -q -m 192M <${root_dir}/specs/gap/gap/data/ref/ref.in 2>${root_dir}/stats/${curr_config}_gap &

    #mesa
    cd ${root_dir}/specs/mesa/data/ref
    ${root_dir}/sim-outorder -config ${root_dir}/config/${curr_config}.txt ${root_dir}/specs/mesa/exe/mesa.exe -frames 10 -meshfile mesa.in -ppmfile mesa.ppm 2>${root_dir}/stats/${curr_config}_mesa &

    wait
    echo 'Finished '${curr_config}

done


#cd ${call_dir}
