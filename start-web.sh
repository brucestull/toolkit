#!/bin/sh
uv run --no-sync -m manage migrate --noinput

# Collect static into STATIC_ROOT so WhiteNoise can serve admin/app CSS with
# DEBUG=false. Must run BEFORE the server starts: WhiteNoise indexes static
# files once at startup and does not auto-refresh in production.
uv run --no-sync -m manage collectstatic --noinput

# Starts the "web" entry in PRODUCTION_PROCESSES (django-prodserver). `exec`
# hands the container's stop signal to the server so it shuts down cleanly
# instead of being killed after the stop timeout.
exec uv run --no-sync -m manage server web
