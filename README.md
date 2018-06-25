# delete_random_pod

> Delete a random pod in kubernetes

## Install

```bash
$ fisher i evanlucas/delete_random_pod
```

## Usage

```fish
➜ kubectl -n testapp get pod
NAME                             READY     STATUS    RESTARTS   AGE
production-5778fd94cd-btnhx      2/2       Running   0          6d
staging-db85b4c5f-4xbmz          2/2       Running   0          10d
staging-db85b4c5f-j69sg          2/2       Running   0          10d
tiller-deploy-769b6496cd-vzvg4   1/1       Running   0          16d

➜ delete_random_pod -n testapp -l app=staging
pod "staging-db85b4c5f-j69sg" deleted
```

## License

MIT
