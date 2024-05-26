#!/bin/bash

tofu init
case $(tofu plan -detailed-exitcode -input=false -no-color -out plan.tfplan) in
    0) export tf_exitcode=0 ;;
    2) export tf_exitcode=2 ;;
    *) export tf_exitcode=1 ;;
esac

echo "tf_exitcode=$tf_exitcode" >> "$GITHUB_OUTPUT"

# echo "~~~ $(tofu show -no-color ./plan.tfplan) ~~~" >> $GITHUB_STEP_SUMMARY
# echo "plan<<EOF" >> $GITHUB_OUTPUT
# echo "$(tofu show -no-color ./plan.tfplan)" >> $GITHUB_OUTPUT
# echo "EOF" >> $GITHUB_OUTPUT

if [[ $tf_exitcode -eq 2 ]]; then
    echo "ADD_TO_PR=true" >> "$GITHUB_ENV"
    exit 0
elif [[ $tf_exitcode -eq 0 ]]; then
    exit 0
else
    exit $tf_exitcode
fi