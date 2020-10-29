source constant.makefile

target=$1
target_name=${target#*:}
query_dir=${tmp_dir}/query/${target_name}
[ -d query_dir ] || mkdir -p ${query_dir}

# http://c.biancheng.net/view/1120.html
# the main target: //Telegram:Telegram
bazel query --noimplicit_deps "deps(${target})" --output graph > ${target_name}.in
dot -Tpng < graph.in > ${query_dir}/${target_name}.png
open ${query_dir}/${target_name}.png

# bazel query 'rdeps(//Telegram:Telegram, //submodules/AlertUI:AlertUI)' --output package