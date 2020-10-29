source $(cd $(dirname "${BASH_SOURCE[0]}"); pwd)/constant.makefile

BAZEL=$(which bazel)

rm -rf $tmp_dir
${BAZEL} clean