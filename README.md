# Spotx API data input plugin for Embulk

Loads records from Spotx API

## Overview

* **Plugin type**: input
* **Resume supported**: no
* **Cleanup supported**: no
* **Guess supported**: no

## Configuration

- **endpoint**: Spotx API endpoint to get data from (string, required)
- **client_id**: Spotx API client ID (string, required)
- **client_secret**: Spotx API client secret (string, required)
- **refresh_token**: Spotx API refresh token (string, required)

## Example

```yaml
in:
  type: spotx
  endpoint: https://api.spotxchange.com/1.0/Publisher($ID)/Channels/AdvertiserReport?date_range=last_7_days
  client_id: $client_id
  client_secret: $client_secret
  refresh_token: $refresh_token
  parser:
    type: json
```


## Build

```
$ rake build
```
