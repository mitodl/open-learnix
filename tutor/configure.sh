#!/usr/bin/env bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR=$(dirname -- "${SCRIPT_DIR}")


TUTOR_CONFIG_DIR=$( tutor config printroot )
TUTOR_PLUGINS_DIR=$( tutor plugins printroot )

echo "Configuring tutor"

tutor mounts add lms,cms:$ROOT_DIR/repos/open-edx-plugins:/openedx/open-edx-plugins

tutor config save \
  --set CADDY_HTTP_PORT=8888 \
  --set ENABLE_WEB_PROXY=false \
  --set LMS_HOST=openedx.odl.local \
  --set PREVIEW_LMD_HOST=preview.openedx.odl.local \
  --set CMS_HOST=studio.openedx.odl.local \
  --set ENABLE_HTTPS=true \

# tutor config save \ 
#   --remove OPENEDX_EXTRA_PIP_REQUIREMENTS="ol-social-auth" \
#   --append OPENEDX_EXTRA_PIP_REQUIREMENTS="-e /openedx/open-edx-plugins/src/ol_social_auth"

tutor config save \
  --append OPENEDX_EXTRA_PIP_REQUIREMENTS="ol-social-auth" \ 
  --remove OPENEDX_EXTRA_PIP_REQUIREMENTS="-e /openedx/open-edx-plugins/src/ol_social_auth"

echo "Symlinking config/plugin customizations"

# create the parent dirs, the dir itself will be symlinked
mkdir -p "$(dirname -- $TUTOR_CONFIG_DIR)"
mkdir -p "$(dirname -- $TUTOR_PLUGINS_DIR)"

# recursively symlink the files
cp -rsf $SCRIPT_DIR/config/* $TUTOR_CONFIG_DIR
cp -rsf $SCRIPT_DIR/plugins/* $TUTOR_PLUGINS_DIR
