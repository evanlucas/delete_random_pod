function delete_random_pod -d 'deletes a random pod'
  set -l options 'h/help' 'n/namespace=' 'l/selector=' 'c/cluster='
  argparse -n delete_random_pod $options -- $argv
  or return

  if set -q _flag_help
    fish_print_file_usage (status -f)
    return 0
  end

  if not set -q _flag_selector
    fish_print_file_usage (status -f)
    return 1
  end

  if set -q _flag_namespace
    set args $args "-n" "$_flag_namespace"
  end

  if set -q _flag_cluster
    set args $args "-c" "$_flag_cluster"
  end

  set -l json (command kubectl get pods -l $_flag_selector $args \
    -o json
  )

  set -l filter (__delete_random_pod_jq_filter)
  set -l pods (echo $json | jq -r $filter)
  kubectl delete pods $args (random choice $pods) --grace-period=30
end

function __delete_random_pod_jq_filter
  set -l a '.items | map(select(.metadata | has("deletionTimestamp") | not)) '
  set -l b '| map(select(.status.containerStatuses | map(.ready) | all)) | '
  set -l c '.[].metadata.name'
  echo $a$b$c
end

### usage
# delete_random_pod: Delete a random kubernetes pod
#
#  usage: delete_random_pod [options]
#
#     -h, --help                         show help and usage
#     -n, --namespace <namespace>        pass namespace
#     -c, --cluster <cluster>            pass cluster
#     -l, --selector <selector>          pass through selector to kubectl
###
