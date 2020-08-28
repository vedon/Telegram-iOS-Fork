source constant.makefile

target=$1
target_name=${target#*:}
graph_dir=${tmp_dir}/graph/${target_name}
[ -d ${graph_dir} ] || mkdir -p ${graph_dir}

# http://c.biancheng.net/view/1120.html
# the main target: //Telegram:Telegram
graph_in_dir=${graph_dir}/${target_name}.in
graph_img_dir=${graph_dir}/${target_name}.png

bazel query --noimplicit_deps "deps(${target})" --output graph > $graph_in_dir
dot -Tpng < $graph_in_dir > $graph_img_dir
open $graph_img_dir