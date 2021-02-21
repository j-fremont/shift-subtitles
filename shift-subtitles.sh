#!/bin/bash

file_in=test.srt
file_out=test_out.srt

perl shift-subtitles.pl $file_in + 00:40 > $file_out

