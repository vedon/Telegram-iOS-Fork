source constant.makefile

target=$1
target_name=${target#*:}
profile_dir=${tmp_dir}/profile/${target_name}

echo $profile_dir
[ -d profile_dir ] || mkdir -p ${profile_dir}

output=${profile_dir}/${target_name}.gz
bazel build --profile=${output} ${target}
bazel analyze-profile ${output}