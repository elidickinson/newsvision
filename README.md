# newsvision

## Set up

```
cp env.list.sample env.list
```
and then edit env.list to include your IDs and API keys

Build the docker image:
```
docker build . --tag newsvision
```

## Executing

Send a random newspaper frontpage:
```
docker run --env-file env.list --rm newsvision
```

Send a particular newspaper frontapge
```
docker run --env-file env.list --rm newsvision /paperme.sh DC_WP
```

See paperindex.tsv for list of options