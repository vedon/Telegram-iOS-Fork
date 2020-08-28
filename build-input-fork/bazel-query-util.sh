[ -d ./query-graph ] || mkdir -p ./query-graph

cd ./query-graph

target=$1
target_name=${target#*:}

# http://c.biancheng.net/view/1120.html
bazel query --noimplicit_deps "deps(${target})" --output graph > ${target_name}.in
dot -Tpng < graph.in > ${target_name}.png
open ${target_name}.png