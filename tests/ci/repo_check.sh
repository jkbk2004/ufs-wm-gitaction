#!/bin/bash
set -eu

get_shas () {
    cwd=$(pwd)
    # Get sha-1's of the top of develop and feature branches
    app="Accept: application/vnd.github.v3+json"
    url=$1
    gitapi=$2
    branch=$3
    base_sha=$(curl -sS -H "$app" $gitapi | jq -r '.commit.sha')
    workspace=$4
    cd $workspace
    git remote add upstream $url
    git fetch -q upstream $branch
    common=$(git merge-base $base_sha @)
    echo $common $base_sha $workspace
    if [[ $common != $base_sha ]]; then
        comment="* $workspace **NOT** up to date"
        printf "%s\n\n" "$comment"
        flag_sync=false
    fi
    cd $cwd
}

flag_sync=true

ownerID=$1

url='https://github.com/jkbk2004/ufs-wm-gitaction'
gitapi='https://api.github.com/repos/jkbk2004/ufs-wm-gitaction/branches/main'
branch='main'
workspace=${GITHUB_WORKSPACE}
get_shas $url $gitapi $branch $workspace

url='https://github.com/NOAA-EMC/fv3atm'
gitapi='https://api.github.com/repos/NOAA-EMC/fv3atm/branches/develop'
branch='develop'
workspace=${GITHUB_WORKSPACE}/'FV3'
get_shas $url $gitapi $branch $workspace

url='https://github.com/NOAA-EMC/MOM6'
gitapi='https://api.github.com/repos/NOAA-EMC/MOM6/branches/dev/emc'
branch='dev/emc'
workspace=${GITHUB_WORKSPACE}/'MOM6-interface/MOM6'
get_shas $url $gitapi $branch $workspace

url='https://github.com/NOAA-EMC/CICE'
gitapi='https://api.github.com/repos/NOAA-EMC/CICE/branches/emc/develop'
branch='emc/develop'
workspace=${GITHUB_WORKSPACE}/'CICE-interface/CICE'
get_shas $url $gitapi $branch $workspace

url='https://github.com/NOAA-EMC/WW3'
gitapi='https://api.github.com/repos/NOAA-EMC/WW3/branches/dev/ufs-weather-model'
branch='dev/ufs-weather-model'
workspace=${GITHUB_WORKSPACE}/'WW3'
get_shas $url $gitapi $branch $workspace

url='https://github.com/noaa-psl/stochastic_physics'
gitapi='https://api.github.com/repos/noaa-psl/stochastic_physics/branches/master'
branch='master'
workspace=${GITHUB_WORKSPACE}/'stochastic_physics'
get_shas $url $gitapi $branch $workspace

url='https://github.com/GEOS-ESM/GOCART'
gitapi='https://api.github.com/repos/GEOS-ESM/GOCART/branches/develop'
branch='develop'
workspace='ufs-wm-gitaction/GOCART'
get_shas $url $gitapi $branch $workspace

url='https://github.com/NOAA-EMC/CMEPS'
gitapi='https://api.github.com/repos/NOAA-EMC/CMEPS/branches/emc/develop'
branch='emc/develop'
workspace=${GITHUB_WORKSPACE}/'CMEPS-interface/CMEPS'
get_shas $url $gitapi $branch $workspace

url='https://github.com/NOAA-EMC/CDEPS'
gitapi='https://api.github.com/repos/NOAA-EMC/CDEPS/branches/develop'
branch='develop'
workspace=${GITHUB_WORKSPACE}/'CDEPS-interface/CDEPS'
get_shas $url $gitapi $branch $workspace

url='https://github.com/NOAA-EMC/HYCOM-src'
gitapi='https://api.github.com/repos/NOAA-EMC/HYCOM-src/branches/emc/develop'
branch='emc/develop'
workspace=${GITHUB_WORKSPACE}/'HYCOM-interface/HYCOM'
get_shas $url $gitapi $branch $workspace

url='https://github.com/NOAA-EMC/CMakeModules'
gitapi='https://api.github.com/repos/NOAA-EMC/CMakeModules/branches/develop'
branch='develop'
workspace=${GITHUB_WORKSPACE}/'CMakeModules'
get_shas $url $gitapi $branch $workspace

url='https://github.com/ufs-community/ccpp-physics'
gitapi='https://api.github.com/repos/ufs-community/ccpp-physics/branches/ufs/dev'
branch='ufs/dev'
workspace=${GITHUB_WORKSPACE}/'FV3/ccpp/physics'
get_shas $url $gitapi $branch $workspace

url='https://github.com/NCAR/ccpp-framework'
gitapi='https://api.github.com/repos/NCAR/ccpp-framework/branches/main'
branch='main'
workspace=${GITHUB_WORKSPACE}/'FV3/ccpp/framework'
get_shas $url $gitapi $branch $workspace

#url='https://github.com/NOAA-EMC/UPP'
#gitapi='https://api.github.com/repos/NOAA-EMC/UPP/branches/develop'
#branch='develop'
#workspace=${GITHUB_WORKSPACE}/'FV3/upp'
#get_shas $url $gitapi $branch $workspace

#url='https://github.com/NOAA-GFDL/GFDL_atmos_cubed_sphere'
#gitapi='https://api.github.com/repos/NOAA-GFDL/GFDL_atmos_cubed_sphere/branches/dev/emc'
#branch='dev/emc'
#workspace=${GITHUB_WORKSPACE}/'FV3/atmos_cubed_sphere'
#get_shas $url $gitapi $branch $workspace
