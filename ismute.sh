#!/bin/bash
pactl list sinks | grep '^[[:space:]]Mute:' | head -n $(( $SINK + 2 )) | tail -n 1 | sed -e 's,.* \(yes\|no\).*,\1,'
