
source $(cd $(dirname "${BASH_SOURCE[0]}"); pwd)/constant.makefile

target=$1
target_name=${target#*:}
# profile_dir=${tmp_dir}/profile
profile_dir=$(cd $(dirname "${BASH_SOURCE[0]}"); pwd)/${tmp_dir}/profile

[ -d profile_dir ] || mkdir -p ${profile_dir}

output=${profile_dir}/${target_name}.gz
echo "Profile path: ${profile_dir}, Output path: ${output}"
bazel build --profile=${output} ${target}
bazel analyze-profile ${output}